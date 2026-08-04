import { defineConfig, configDefaults } from 'vitest/config';
import { cloudflareTest } from '@cloudflare/vitest-pool-workers';

// A 0.20 do `@cloudflare/vitest-pool-workers` trocou a forma da configuração:
// `defineWorkersConfig` (importado de `.../config`) deixou de existir, e o pool
// virou um plugin do Vite — `cloudflareTest()`. O subcaminho `/config` nem é
// mais exportado pelo pacote, então a config antiga falhava já no carregamento,
// antes de qualquer teste rodar.
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
    // cópias inteiras dela mesma e a contagem triplica.
    //
    // `exclude` SUBSTITUI os defaults do vitest, então `configDefaults.exclude`
    // (node_modules, dist, .idea, .git, .cache) precisa ser reincluído — sem
    // isso o vitest passaria a varrer `node_modules`.
    exclude: [...configDefaults.exclude, 'frontend/**', '.claude/**'],
  },
});
