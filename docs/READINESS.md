# Production Readiness — nISO

> Estado de prontidão para produção, honesto e rastreável. Atualizado em 2026-08-08.
> Legenda: ✅ verificado · ⚠️ risco conhecido · ⏳ pendente (dono indicado).

## Entrega e deploy

- ✅ **Deploy automatizado** (`.github/workflows/deploy.yml`): dispara no push para
  `main` e via `workflow_dispatch`. Antes disso o deploy era manual e produção
  ficava semanas atrás do `main` — origem, por exemplo, do "questionário sumido".
- ✅ **Gate de deploy**: `tsc` + testes + build do frontend antes de publicar;
  **recusa deploy com migration pendente**.
- ✅ **Ambiente `production`** — aprovação humana configurável em Settings
  ("Required reviewers" no environment).
- ⚠️ **Teste flaky pode bloquear deploy**: o pool `@cloudflare/vitest-pool-workers`
  às vezes emite `TypeError: fetch failed / other side closed` no teardown entre
  arquivos (erro do runtime de teste, não do app). Passou em #60/#61, mas é
  intermitente. Mitigação recomendada: adicionar retry ao passo de testes do
  deploy, ou fixar/atualizar a versão do pool. **Não** mascarar com
  `dangerouslyIgnoreUnhandledErrors`.

## Segurança

- ✅ **Auth por API key real** (`X-API-Key`), com papéis (`consultant`/`auditor`/
  `read`/`write`/`admin`) e **escopo de projeto** (chave presa a um projeto; falha
  fechado sem projeto). Ver `src/middleware/auth.ts`, `src/auth-policy.ts`.
- ✅ **Separação consultor/auditor** no backend (independência ISO 27001 §9.2).
- ✅ **MFA** no login, revogação de sessão, `X-nISO-Signature` em webhooks.
- ✅ **CSP + security headers + `security.txt`**, rate limit, body guard,
  isolamento multi-tenant (`projectAccessMiddleware`), audit-log append-only.
- ✅ **Chaves de API**: só o hash (SHA-256) é armazenado; texto puro exibido uma
  vez; gestão exclusiva do Platform Admin (tela + gate de backend); expiração
  padrão de 90 dias na criação pela UI.
- ⏳ **Rotação de segredos** (chaves de agente, `CLOUDFLARE_API_TOKEN`): definir
  cadência. Dono: **operação**.

## Testes e qualidade

- ✅ Suíte de worker (~340 testes) + frontend (140) — verdes localmente e no CI.
- ✅ CI por PR + review automatizado (Codex, CodeRabbit).
- ⏳ **Teste E2E da integração MCP** contra o ambiente publicado (criar chave real
  → MCP conecta → consultor escreve, auditor é barrado, projeto errado recusado).
  Hoje há cobertura unitária da política; falta o loop ponta-a-ponta. Dono:
  **plataforma** (usar a nova tela de API keys para emitir a chave).

## Dados e operação

- ✅ **Backup do D1**: `npm run db:backup` (runbook em `backups/README.md`).
- ✅ **Migrations gated** no deploy (não aplica sozinho; recusa código à frente do schema).
- ✅ **Observabilidade**: log estruturado (uma linha JSON por request) + binding
  Analytics Engine.
- ⏳ **Alerta/monitoramento ativo** (erro 5xx, latência, falha de deploy): confirmar
  se há dashboard/alerta consumindo os logs/métricas. Dono: **operação**.
- ⏳ **Plano de DR / teste de restore** do backup: validar restauração ao menos uma
  vez. Dono: **operação**.

## Veredito

- **Piloto assistido com cliente real: pronto.** Pipeline, segurança e dados estão
  em pé; produção reflete o `main`.
- **GA / uso desassistido:** fechar os ⏳ acima (E2E do MCP, alerta/monitoramento,
  DR testado, rotação de segredos) e o ⚠️ do teste flaky.
