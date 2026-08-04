import { describe, it, expect, beforeAll } from 'vitest';
import { env } from 'cloudflare:test';
import { execSql } from './helpers/d1';
import migration0022 from '../migrations/0022_corrective_actions_updated_at.sql?raw';

/**
 * Ensaio da migration 0022 contra o schema ANTERIOR a ela.
 *
 * Bem mais simples que a 0021: aqui é `ADD COLUMN` + backfill, não rebuild de
 * tabela, então não há DROP capaz de levar dado junto. O que precisa ser
 * verificado é o backfill — uma coluna nova nasce NULL em toda linha existente,
 * e linha com `updated_at` nulo é pior que a ausência da coluna: a UI mostraria
 * "sem data de alteração" para ação corretiva que existe há meses.
 *
 * `corrective_actions` é reproduzida aqui EXATAMENTE como estava no `schema.sql`
 * antes desta migration. Se ela fosse importada do schema atual, a coluna já
 * viria criada e o teste não ensaiaria nada.
 */
const LEGADO = `
CREATE TABLE IF NOT EXISTS projects (
    id TEXT PRIMARY KEY,
    client_name TEXT NOT NULL
);
CREATE TABLE corrective_actions (
    id TEXT PRIMARY KEY,
    project_id TEXT REFERENCES projects(id) ON DELETE CASCADE,
    audit_id TEXT,
    risk_id TEXT,
    control_id TEXT,
    title TEXT NOT NULL,
    description TEXT,
    root_cause TEXT,
    action_plan TEXT,
    severity TEXT DEFAULT 'Medium',
    assigned_to TEXT,
    due_date TEXT,
    status TEXT DEFAULT 'Open',
    resolution TEXT,
    completed_at DATETIME,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);
`;

describe('migration 0022 — `updated_at` em corrective_actions', () => {
  beforeAll(async () => {
    await execSql(LEGADO);
    await env.DB.batch([
      env.DB.prepare(`INSERT INTO projects (id, client_name) VALUES ('p1','Cliente Um')`),
      env.DB.prepare(
        `INSERT INTO corrective_actions (id, project_id, title, description, severity, status, created_at)
         VALUES ('ca-antiga','p1','NC de 2024','descricao','High','Open','2024-03-07 10:11:12')`
      ),
      env.DB.prepare(
        `INSERT INTO corrective_actions (id, project_id, title, status, created_at)
         VALUES ('ca-fechada','p1','NC ja tratada','Closed','2025-06-01 08:00:00')`
      ),
    ]);
    await execSql(migration0022);
  });

  it('cria a coluna que o handler de achado de auditoria escreve', async () => {
    const { results } = await env.DB.prepare('PRAGMA table_info(corrective_actions)').all<any>();
    expect((results || []).map((c: any) => c.name)).toContain('updated_at');
  });

  it('faz backfill com `created_at` — nenhuma linha antiga fica sem data', async () => {
    // O valor honesto para uma linha que nunca foi alterada é a data em que foi
    // criada. `CURRENT_TIMESTAMP` no backfill afirmaria que toda CAPA do banco
    // foi mexida no dia da migration, o que é falso e apaga a informação real.
    const antiga = await env.DB.prepare("SELECT created_at, updated_at FROM corrective_actions WHERE id='ca-antiga'").first<any>();
    expect(antiga.updated_at).toBe('2024-03-07 10:11:12');
    expect(antiga.updated_at).toBe(antiga.created_at);

    const semData = await env.DB.prepare('SELECT count(*) AS n FROM corrective_actions WHERE updated_at IS NULL').first<any>();
    expect(semData.n).toBe(0);
  });

  it('preserva as linhas e as demais colunas', async () => {
    const total = await env.DB.prepare('SELECT count(*) AS n FROM corrective_actions').first<any>();
    expect(total.n).toBe(2);

    const ca = await env.DB.prepare("SELECT * FROM corrective_actions WHERE id='ca-antiga'").first<any>();
    expect(ca.title).toBe('NC de 2024');
    expect(ca.severity).toBe('High');
    expect(ca.project_id).toBe('p1');
  });

  it('aceita o INSERT do handler depois de aplicada', async () => {
    // A prova final: o statement de `src/routes/governance.ts` que falhava.
    await env.DB.prepare(
      `INSERT INTO corrective_actions (id, project_id, audit_id, control_id, title, description, severity, status, created_at, updated_at)
       VALUES ('ca-nova','p1',NULL,NULL,'NC (Maior): teste','descricao','High','Open',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP)`
    ).run();
    const nova = await env.DB.prepare("SELECT updated_at FROM corrective_actions WHERE id='ca-nova'").first<any>();
    expect(nova.updated_at).toBeTruthy();
  });
});
