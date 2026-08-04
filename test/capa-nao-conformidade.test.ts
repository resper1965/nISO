import { describe, it, expect, beforeAll } from 'vitest';
import { env } from 'cloudflare:test';
import worker from '../src/index';
import { applySchema, sessionFor } from './helpers/d1';

/**
 * Registro de não-conformidade de auditoria interna, ponta a ponta contra D1 real.
 *
 * O caminho estava quebrado em produção: `src/routes/governance.ts` inseria em
 * `corrective_actions (..., updated_at)` e a coluna não existia. O INSERT da CAPA
 * vem ANTES do INSERT em `audit_findings`, então uma NC menor ou maior não
 * gravava NADA — nem a ação corretiva, nem o achado — e o chamador recebia 500.
 *
 * O `schema-contract.test.ts` existe para pegar exatamente esse tipo de defeito,
 * mas cobria os INSERTs de evidence, assets e DPIA, não o de `corrective_actions`.
 * Aquele arquivo ganhou o caso que faltava; aqui a rota é exercida inteira,
 * porque o que interessa não é só o INSERT compilar: é o achado e a CAPA
 * existirem e estarem ligados um ao outro no fim da requisição.
 *
 * Cada `it` usa ids próprios em vez de reaproveitar linha de teste vizinho — o
 * arquivo não depende da ordem de execução nem de rollback entre testes.
 */
describe('Não-conformidade de auditoria gera CAPA (D1 real)', () => {
  const PROJ = 'proj-nc';
  let headers: Record<string, string>;

  async function post(path: string, body: unknown) {
    return worker.fetch(
      new Request(`http://localhost${path}`, { method: 'POST', headers, body: JSON.stringify(body) }),
      env as any
    );
  }

  beforeAll(async () => {
    await applySchema();
    await env.DB.batch([
      env.DB.prepare(
        `INSERT INTO projects (id, client_name, standards, org_role, status) VALUES (?, 'Cliente NC', 'ISO 27001', 'controller', 'Active')`
      ).bind(PROJ),
      env.DB.prepare(
        `INSERT INTO users (id, email, password_hash, name, role) VALUES ('usr-nc','auditor@ness.dev','x','Auditor Interno','platform_admin')`
      ),
    ]);
    headers = {
      ...(await sessionFor({ id: 'usr-nc', email: 'auditor@ness.dev', name: 'Auditor Interno', role: 'platform_admin' })),
      'Content-Type': 'application/json',
    };
  });

  async function semearAuditoria(auditId: string) {
    await env.DB.prepare(
      `INSERT INTO audit_schedule (id, project_id, audit_type, title, scheduled_date, status)
       VALUES (?, ?, 'internal', 'Auditoria interna 2026', '2026-09-01', 'Planned')`
    ).bind(auditId, PROJ).run();
  }

  for (const tipo of ['minor_nc', 'major_nc'] as const) {
    it(`grava achado E ação corretiva para ${tipo}`, async () => {
      const auditId = `aud-${tipo}`;
      await semearAuditoria(auditId);

      const res = await post(`/api/v1/audits/${auditId}/findings`, {
        project_id: PROJ,
        finding_type: tipo,
        description: 'Registros de treinamento ausentes para dois colaboradores.',
      });
      const body = await res.json() as any;
      expect(res.status, JSON.stringify(body)).toBe(200);
      expect(body.ok).toBe(true);
      expect(body.capa_id).toBeTruthy();

      // A CAPA é o registro que prova tratativa da NC. Sem a coluna `updated_at`
      // este INSERT era o que derrubava a requisição inteira.
      const capa = await env.DB.prepare(
        'SELECT project_id, audit_id, status, severity, created_at, updated_at FROM corrective_actions WHERE id = ?'
      ).bind(body.capa_id).first<any>();
      expect(capa).not.toBeNull();
      expect(capa.project_id).toBe(PROJ);
      expect(capa.audit_id).toBe(auditId);
      expect(capa.status).toBe('Open');
      expect(capa.severity).toBe(tipo === 'major_nc' ? 'High' : 'Medium');
      expect(capa.updated_at).toBeTruthy();

      // E o achado, ligado à CAPA: um sem o outro não fecha a trilha de 9.2/10.1.
      const achado = await env.DB.prepare(
        'SELECT project_id, capa_id, finding_type FROM audit_findings WHERE id = ?'
      ).bind(body.id).first<any>();
      expect(achado).not.toBeNull();
      expect(achado.capa_id).toBe(body.capa_id);
      expect(achado.finding_type).toBe(tipo);
      expect(achado.project_id).toBe(PROJ);
    });
  }

  it('observação grava o achado sem abrir ação corretiva', async () => {
    const auditId = 'aud-obs';
    await semearAuditoria(auditId);

    const res = await post(`/api/v1/audits/${auditId}/findings`, {
      project_id: PROJ,
      finding_type: 'observation',
      description: 'Oportunidade de melhoria no controle de acesso físico.',
    });
    const body = await res.json() as any;
    expect(res.status, JSON.stringify(body)).toBe(200);
    expect(body.capa_id).toBeNull();

    const achado = await env.DB.prepare('SELECT capa_id FROM audit_findings WHERE id = ?').bind(body.id).first<any>();
    expect(achado.capa_id).toBeNull();

    const capas = await env.DB.prepare(
      'SELECT count(*) AS n FROM corrective_actions WHERE audit_id = ?'
    ).bind(auditId).first<any>();
    expect(capas.n).toBe(0);
  });

  it('editar a CAPA move `updated_at` para depois de `created_at`', async () => {
    // Uma coluna preenchida só na criação e congelada depois é pior que coluna
    // nenhuma: parece dizer "última alteração" e não diz. Este teste é o que
    // impede que ela volte a ser decorativa.
    const capaId = 'capa-edit';
    await env.DB.prepare(
      `INSERT INTO corrective_actions (id, project_id, title, description, severity, status, created_at, updated_at)
       VALUES (?, ?, 'NC: registros ausentes', 'descricao', 'Medium', 'Open', '2020-01-01 00:00:00', '2020-01-01 00:00:00')`
    ).bind(capaId, PROJ).run();

    const res = await worker.fetch(
      new Request(`http://localhost/api/v1/capa/${capaId}`, {
        method: 'PUT',
        headers,
        body: JSON.stringify({
          title: 'NC: registros ausentes',
          description: 'Treinamento reaplicado; evidência anexada.',
          severity: 'Medium',
          assigned_to: 'rh@cliente.com',
          due_date: '2026-10-01',
          status: 'Closed',
          resolution: 'Registros regularizados.',
        }),
      }),
      env as any
    );
    expect(res.status, await res.clone().text()).toBe(200);

    const capa = await env.DB.prepare(
      'SELECT created_at, updated_at, status, completed_at FROM corrective_actions WHERE id = ?'
    ).bind(capaId).first<any>();
    expect(capa.status).toBe('Closed');
    expect(capa.completed_at).toBeTruthy();
    expect(capa.updated_at > capa.created_at).toBe(true);
  });
});
