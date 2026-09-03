import { cloudflareTest } from '@cloudflare/vitest-pool-workers';
import { defineConfig, configDefaults } from 'vitest/config';

// Migrado para vitest 4 + @cloudflare/vitest-pool-workers 0.20.x: a API de
// `poolOptions.workers` saiu; o pool agora entra como PLUGIN `cloudflareTest`.
export default defineConfig({
  plugins: [
    cloudflareTest({
      wrangler: { configPath: './wrangler.test.jsonc' },
    }),
  ],
  test: {
    // Esta suíte roda no runtime de Workers. `frontend/` tem a sua própria, sob
    // jsdom (`frontend/vitest.config.js`), e os testes de lá se penduram em
    // `window`/`localStorage`: varridos por aqui, quebram com "window is not
    // defined", que parece bug do teste e é só escopo errado do config.
    //
    // `.claude/` guarda os worktrees dos agentes. Sem excluí-los, a suíte varre
    // cópias inteiras dela mesma e a contagem triplica (81 arquivos onde são
    // ~30) — não afeta o CI, mas engana quem roda local.
    //
    // `exclude` SUBSTITUI os defaults do vitest, então `configDefaults.exclude`
    // (node_modules, dist, .idea, .git, .cache) precisa ser reincluído — sem
    // isso o vitest passaria a varrer `node_modules`.
    exclude: [...configDefaults.exclude, 'frontend/**', '.claude/**'],
    // Reporters extras SO em CI (GITHUB_ACTIONS): local fica com o `default`.
    // `github-actions` anota a falha na linha exata do PR; `junit` vira resumo
    // "X passaram / Y falharam".
    reporters: process.env.GITHUB_ACTIONS
      ? ['default', 'github-actions', ['junit', { outputFile: 'test-results/worker-junit.xml' }]]
      : ['default'],
    // Cobertura do backend usa ISTANBUL, nao v8: o provider v8 depende de
    // `node:inspector`, que o runtime de Workers (workerd) nao tem — falha com
    // "No such module node:inspector/promises" em qualquer versao. Istanbul
    // instrumenta o codigo no transform (Vite), roda dentro do workerd e coleta
    // `__coverage__`. So roda com `--coverage` (script `test:coverage`); o
    // `npm test` continua rapido.
    coverage: {
      provider: 'istanbul',
      // So .ts de src/. `src/templates/**` sao .md inlinados via `?raw` — o
      // instrumentador do istanbul tenta parsear e quebra; ficam de fora.
      include: ['src/**/*.ts'],
      exclude: ['src/templates/**', '**/*.d.ts'],
      // `all: true` conta TODO o src/, inclusive o que nenhum teste toca, senao
      // a % mede so o pedaco exercitado e esconde o descoberto.
      all: true,
      reporter: ['text-summary', 'html', 'json-summary', 'lcov'],
      reportsDirectory: 'coverage',
      // Piso de catraca fixado alguns pontos abaixo do atingido para barrar
      // REGRESSAO sem inventar meta. Subir junto conforme os testes crescem.
      //
      // 2026-08: ~55.8% stmts / 43% br / 62.6% fn / 57.7% lines, após os testes
      //   de agents/ (assessment, evidence) e services/ RAG.
      // 2026-09: 60.9% stmts / 47.9% br / 66.6% fn / 63.1% lines, após o
      //   inventário de IDOR nos recursos de topo (capa, ropa, certification,
      //   assets, dpia, webhooks, api-keys, notifications, audits).
      thresholds: {
        statements: 57,
        branches: 44,
        functions: 63,
        lines: 59,
      },
    },
  },
});
