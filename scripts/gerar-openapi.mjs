/**
 * Escreve `docs/openapi.json` a partir de `src/openapi.ts`.
 *
 * O documento é servido em runtime pelo Worker; este arquivo existe para que a
 * mudança de contrato APAREÇA NO DIFF do PR. Trocar um `.min(1)` por `.min(8)`
 * num schema é uma linha fácil de não ver; a mesma mudança no `openapi.json` é
 * uma linha que diz `"minLength": 8`, e o revisor vê.
 *
 * `test/openapi.test.ts` compara o arquivo com o que o código gera e falha se
 * alguém mudar schema sem rodar isto — o snapshot não pode ficar velho.
 *
 * Passa por esbuild em vez de `node --experimental-strip-types` porque o
 * type-stripping do Node não resolve import de diretório (`./schemas`) nem
 * extensão implícita, e adaptar a árvore inteira de `src/` a isso seria mexer em
 * dezenas de arquivos para agradar um script. O esbuild já é dependência do
 * wrangler e resolve como o bundle de produção resolve — que é justamente o
 * comportamento que queremos reproduzir.
 *
 * Uso: `npm run openapi`
 */
import { writeFileSync, rmSync } from 'node:fs';
import { pathToFileURL } from 'node:url';
import esbuild from 'esbuild';

// O bundle sai DENTRO do projeto, e não em /tmp: `zod` fica externo (não faz
// sentido embutir uma cópia só para ler schemas), e módulo em /tmp não enxerga
// o node_modules daqui.
const saida = new URL('../node_modules/.cache/niso-openapi.mjs', import.meta.url).pathname;

await esbuild.build({
  entryPoints: [new URL('../src/openapi.ts', import.meta.url).pathname],
  outfile: saida,
  bundle: true,
  format: 'esm',
  platform: 'node',
  external: ['zod'],
  logLevel: 'warning',
});

const { documentoOpenApi } = await import(pathToFileURL(saida).href);
const doc = documentoOpenApi('https://niso.ness.workers.dev');
rmSync(saida, { force: true });

writeFileSync(new URL('../docs/openapi.json', import.meta.url), JSON.stringify(doc, null, 2) + '\n');
console.log(`docs/openapi.json: ${Object.keys(doc.paths).length} caminhos`);
