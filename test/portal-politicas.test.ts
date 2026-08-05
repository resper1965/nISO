import { describe, it, expect, beforeAll } from 'vitest';
import { env } from 'cloudflare:test';
import worker from '../src/index';
import { applySchema } from './helpers/d1';

/**
 * Portal público de políticas: registro de ciência (`POST /public/policies/ack`).
 *
 * Este caminho não tinha teste nenhum, e é o que produz a evidência de que uma
 * pessoa NOMEADA leu e aceitou uma política — o registro que um auditor pede
 * para A.5.1/5.10 e para a trilha de conscientização da LGPD.
 *
 * A sessão `pubpol_sess_*` só nasce depois de um OTP conferido contra o e-mail
 * (ver `/policies/verify` em `src/routes/public.ts`), então ela É a identidade
 * verificada. O handler, porém, preferia o que viesse no CORPO:
 *
 *     const nameToRecord  = user_name  || session.name;
 *     const emailToRecord = user_email || session.email;
 *
 * Quer dizer: quem verificasse o próprio e-mail gravava ciência em nome de
 * qualquer colega. Os testes abaixo fixam a identidade na sessão.
 */
const PROJ = 'proj-portal';
const TOKEN = 'tok-portal-1';

async function req(path: string, init: RequestInit = {}) {
  return worker.fetch(new Request(`http://localhost${path}`, init), env as any);
}

describe('Portal público de políticas — ciência eletrônica', () => {
  beforeAll(async () => {
    await applySchema();
    await env.DB.prepare(
      `INSERT INTO projects (id, client_name, standards, org_role, status) VALUES (?, 'Cliente Portal', 'ISO 27001', 'controller', 'Active')`
    ).bind(PROJ).run();

    await env.SESSIONS.put(
      `pubpol_sess_${TOKEN}`,
      JSON.stringify({
        project_id: PROJ,
        name: 'Maria Souza',
        email: 'maria@empresa.com',
        authenticated_at: new Date().toISOString(),
      }),
      { expirationTtl: 7200 }
    );
  });

  async function ack(body: unknown, token: string | null = TOKEN) {
    const qs = token ? `?token=${token}` : '';
    return req(`/api/v1/public/policies/ack${qs}`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(body),
    });
  }

  it('exige token de sessão', async () => {
    expect((await ack({ policy_type: 'ISP' }, null)).status).toBe(401);
  });

  it('recusa sessão inexistente ou expirada', async () => {
    expect((await ack({ policy_type: 'ISP' }, 'tok-que-nao-existe')).status).toBe(401);
  });

  it('exige o tipo da política', async () => {
    expect((await ack({})).status).toBe(400);
  });

  it('grava a ciência com a identidade da sessão', async () => {
    const res = await ack({ policy_type: 'Política de Segurança da Informação' });
    const body = await res.json() as any;
    expect(res.status, JSON.stringify(body)).toBe(200);

    const linha = await env.DB.prepare(
      'SELECT project_id, policy_type, user_name, user_email, acknowledged_at, ip_address, user_agent FROM policy_acknowledgments WHERE id = ?'
    ).bind(body.id).first<any>();
    expect(linha).not.toBeNull();
    expect(linha.project_id).toBe(PROJ);
    expect(linha.user_name).toBe('Maria Souza');
    expect(linha.user_email).toBe('maria@empresa.com');
    // Sem quando/de onde, a ciência não serve de evidência para auditor.
    expect(linha.acknowledged_at).toBeTruthy();
    expect(linha.ip_address).toBeTruthy();
    expect(linha.user_agent).toBeTruthy();
  });

  it('IGNORA nome e e-mail vindos do corpo — não se assina ciência por outra pessoa', async () => {
    // O ataque: sessão legítima da Maria, corpo alegando ser o diretor.
    const res = await ack({
      policy_type: 'Política de Uso Aceitável',
      user_name: 'Joao Diretor',
      user_email: 'diretor@empresa.com',
    });
    const body = await res.json() as any;
    expect(res.status, JSON.stringify(body)).toBe(200);

    // A resposta não pode confirmar a identidade forjada...
    expect(body.user_email).toBe('maria@empresa.com');
    expect(body.user_name).toBe('Maria Souza');

    // ...e o que vale é a LINHA, não o que a resposta disse.
    const linha = await env.DB.prepare(
      "SELECT user_name, user_email FROM policy_acknowledgments WHERE policy_type = 'Política de Uso Aceitável'"
    ).first<any>();
    expect(linha.user_email).toBe('maria@empresa.com');
    expect(linha.user_name).toBe('Maria Souza');

    const doDiretor = await env.DB.prepare(
      "SELECT count(*) AS n FROM policy_acknowledgments WHERE user_email = 'diretor@empresa.com'"
    ).first<any>();
    expect(doDiretor.n).toBe(0);

    // A trilha de auditoria registra quem de fato agiu.
    const log = await env.DB.prepare(
      "SELECT actor FROM audit_logs WHERE action = 'policy.acknowledged_public' ORDER BY rowid DESC LIMIT 1"
    ).first<any>();
    expect(log.actor).toBe('maria@empresa.com');
  });

  it('a ciência fica no projeto da sessão, não num projeto escolhido pelo chamador', async () => {
    await env.DB.prepare(
      `INSERT INTO projects (id, client_name, standards, org_role, status) VALUES ('proj-alheio', 'Outro Cliente', 'ISO 27001', 'controller', 'Active')`
    ).run();

    const res = await ack({ policy_type: 'Política de Backup', project_id: 'proj-alheio' });
    const body = await res.json() as any;
    expect(res.status).toBe(200);

    const linha = await env.DB.prepare(
      'SELECT project_id FROM policy_acknowledgments WHERE id = ?'
    ).bind(body.id).first<any>();
    expect(linha.project_id).toBe(PROJ);
  });
});

/**
 * Fluxo completo de OTP (`request-otp` -> `verify-otp` -> `ack`), fora do fixture
 * fixo acima — é o caminho que um atacante de verdade percorre, e por onde
 * `session.name` nasce.
 *
 * `/policies/request-otp` recebia `name` do corpo e o gravava como estava, sem
 * verificar nada além do e-mail: quem controlasse o PRÓPRIO e-mail podia se
 * apresentar como qualquer outra pessoa, e esse nome seguia intacto até virar a
 * assinatura no registro de conformidade. Achado do Codex na revisão deste PR.
 *
 * A correção não filtra o nome — deixa de LER o campo. `cleanName` passa a vir
 * sempre da parte local do e-mail, o único dado que o OTP de fato prova.
 */
describe('Portal público de políticas — o nome nunca vem do formulário de OTP', () => {
  const PROJ2 = 'proj-portal-otp';

  beforeAll(async () => {
    // `describe` próprio, schema próprio: sob este pool o storage de um
    // `beforeAll` não é visto pelo `beforeAll` de outro `describe` no mesmo
    // arquivo — cada um roda isolado.
    await applySchema();
    await env.DB.prepare(
      `INSERT INTO projects (id, client_name, standards, org_role, status) VALUES (?, 'Cliente OTP', 'ISO 27001', 'controller', 'Active')`
    ).bind(PROJ2).run();
  });

  it('quem pede o OTP para o PRÓPRIO e-mail alegando ser outra pessoa não assina como ela', async () => {
    // O ataque: e-mail é realmente do atacante (ele recebe o OTP), mas o nome
    // alegado é o de um diretor. Antes desta correção, esse nome sobrevivia
    // inteiro até o registro de ciência.
    const pedido = await req('/api/v1/public/policies/request-otp', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ project_id: PROJ2, name: 'Diretor Financeiro', email: 'atacante@empresa.com' }),
    });
    const { demo_otp } = await pedido.json() as any;
    expect(demo_otp).toBeTruthy();

    const verificacao = await req('/api/v1/public/policies/verify-otp', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ project_id: PROJ2, email: 'atacante@empresa.com', otp: demo_otp }),
    });
    const sessao = await verificacao.json() as any;
    expect(sessao.token).toBeTruthy();

    // O nome nunca chega a existir: nem na resposta do OTP...
    expect(sessao.name).toBe('atacante');
    expect(sessao.name).not.toContain('Diretor');

    const res = await worker.fetch(
      new Request(`http://localhost/api/v1/public/policies/ack?token=${sessao.token}`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ policy_type: 'Política de Ética' }),
      }),
      env as any
    );
    const ackBody = await res.json() as any;
    expect(res.status, JSON.stringify(ackBody)).toBe(200);

    // ...nem na linha gravada.
    const linha = await env.DB.prepare(
      "SELECT user_name, user_email FROM policy_acknowledgments WHERE policy_type = 'Política de Ética'"
    ).first<any>();
    expect(linha.user_email).toBe('atacante@empresa.com');
    expect(linha.user_name).toBe('atacante');
    expect(linha.user_name).not.toContain('Diretor');
  });
});
