# Testes — como ler o resultado detalhado

O objetivo aqui não é "passou/falhou": é **enxergar o detalhe** — qual teste
caiu, em que linha, e quanto do código está coberto.

## Suites

| Suite | Runtime | Config | Nº de arquivos |
|---|---|---|---|
| Worker (backend) | runtime real do Cloudflare Workers (`@cloudflare/vitest-pool-workers`) | `vitest.config.mts` | ~34 |
| Frontend | jsdom (DOM simulado) | `frontend/vitest.config.js` | 7 |
| MCP server | build (tsc) | `mcp-server-niso/` | — |

## Rodar local

```bash
# Worker (raiz)
npm test                        # roda a suite do worker

# Frontend
cd frontend
npm test                        # rapido, sem cobertura
npm run test:coverage           # com cobertura + piso de catraca
```

Abra `frontend/coverage/index.html` no navegador para o relatório navegável
(linha a linha, o que cada teste exercita e o que ninguém toca).

## O que o CI produz (resultado detalhado no PR)

Só em CI (`GITHUB_ACTIONS=true`), sem poluir o rodar local:

- **`github-actions` reporter** — a falha aparece **anotada na linha exata**
  dentro do diff do PR, sem caçar no log.
- **`junit` reporter** — XML que o GitHub resume por teste
  (`test-results/worker-junit.xml`, `frontend/test-results/frontend-junit.xml`).
- **Cobertura do frontend** — `html` + `lcov` + `json-summary`.

Todos são publicados como o artefato **`test-reports`** do run (inclusive quando
a suite falha — `if: always()`), retido por 14 dias.

## Piso de cobertura (catraca)

`frontend/vitest.config.js` fixa um piso mínimo (`coverage.thresholds`) logo
abaixo da cobertura atual. Ele **barra regressão**: se um PR derruba a cobertura
abaixo do piso, o CI falha. Não é uma meta de qualidade — é um trinco. Ao subir
a cobertura de verdade, suba o piso junto.

Base 2026-08 (com `all: true`, contando todo o `src/`): ~6,9% de statements. O
número é baixo porque as views grandes (dashboard, admin, project) não têm teste
**unitário** — elas são exercitadas pelos testes de integração do worker, e a
cobertura real delas viria de **E2E de navegador (Playwright)**, ainda não montado.

## Pendência conhecida: cobertura do backend

A suite do worker **não reporta cobertura** hoje. O pool desta stack
(`@cloudflare/vitest-pool-workers` 0.4.x + `vitest` 1.5.x) não instrumenta v8 de
forma confiável — os testes rodam dentro do `workerd`, não do Node. Habilitar
cobertura do backend exige **upgrade do pool/vitest**, tratado em PR próprio para
não misturar um bump de dependência crítico com esta mudança aditiva.
