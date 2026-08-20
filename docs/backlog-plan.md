# Plano — gaps e débitos técnicos (2026-08)

Consolida a triagem da API v1 (`api-triage-2026-08.md`) e o débito de UI num plano
executável: causa, correção, arquivos, esforço, risco e ordem.

Esforço: **S** ≤2h · **M** meio dia · **L** ≥1 dia. Prioridade: P1 (fazer já) → P4.

| ID | Débito | Sev | Esforço | Prio |
|----|--------|-----|---------|------|
| D1 | `repository_token` em texto claro no D1 | 🔴 | M | **P1** |
| D2 | `evaluation_status` sem enum/CHECK (#6) | 🟠 | M | P2 |
| D3 | Sem endpoint de revogar aprovação (#3) | 🟡 | S | P3 |
| D4 | `GET /assessments` 403 p/ chave consultor (#9) | 🟡 | S+? | P3 |
| D5 | Sem OpenAPI + `control-adequacao` base sem handler (#7/#8) | 🟢 | M | P4 |
| D6 | Tela de governança (UI) | 🟢 | M | paralelo |

Ordem: **D1 → D2 → D3/D4 → D5**. D6 corre em paralelo (branch própria).

---

## D1 — cifrar `repository_token` em repouso · P1

**Causa.** O token do repositório do cliente é gravado em texto claro em
`projects.repository_token`. O #107 removeu o campo das respostas (`redactProject`),
mas quem tem acesso ao D1 ainda lê o segredo.

**Correção.**
1. Helper de cripto (WebCrypto AES-GCM) com chave derivada de um secret novo
   (`TOKEN_ENC_KEY`, via `wrangler secret`); nonce por registro.
2. Migração: coluna `repository_token_enc` (BLOB/text base64). Script admin
   (endpoint protegido, uso único) cifra os tokens existentes.
3. Ponto de uso (git ops) passa a decifrar sob demanda; nunca reexpõe em resposta.
4. Depois de migrado, dropar `repository_token`.

**Arquivos.** `src/helpers/crypto.ts` (novo), `src/routes/projects.ts`, migração D1,
`wrangler.toml` (binding do secret).

**Risco.** Médio — migração de dados + rotação de secret. Mitigar: manter as duas
colunas durante a transição, cutover só após verificar decifragem.

---

## D2 — enum de `evaluation_status` · P2

**Causa.** `/evaluate` normaliza para `conforming|partial|non_conforming|pending`, mas
não há garantia no banco; algum caminho aceitou caixa livre ("Conforme"/"conforme").

**Correção.**
1. **Repro** — obter a requisição exata que gravou valor fora do enum.
2. Validação `zod` (enum) em **todos** os writes de `evaluation_status`.
3. Migração: normalizar linhas existentes → adicionar `CHECK (evaluation_status IN (...))`.

**Arquivos.** `src/routes/evidence.ts`, `src/schemas.ts`, migração D1.

**Risco.** Baixo — o CHECK falha se restar linha fora do enum; normalizar **antes** de aplicar.

---

## D3 — revogar aprovação de controle · P3

**Causa.** Hoje a aprovação só cai como efeito colateral da mudança de texto do
controle. Não há ação explícita de retratar.

**Decisão antes de codar.** Retratar aprovação é requisito de processo? Se não, fica
como está (backlog fechado).

**Correção (se sim).** `POST /controls/:id/revoke-approval` com assinatura (senha),
aterramento de tenant, volta status para `Draft`/`Review`, limpa carimbos
`ciso_*`/`ceo_*`, grava `control.approval_revoked` no audit.

**Arquivos.** `src/routes/controls.ts`.

**Risco.** Baixo.

---

## D4 — `GET /assessments` 403 p/ chave consultor · P3

**Causa.** Incerta. Hipótese: guard de isolamento sobre chave escopada em projeto
acessando dado comercial cross-project.

**Correção.**
1. **Repro** com a chave/headers exatos.
2. Se isolamento intencional → mensagem clara + doc.
3. Se gap → ajustar a policy/gate de papel.

**Arquivos.** rota de `assessments`, helpers de auth.

**Risco.** Baixo. Bloqueia em repro.

---

## D5 — descoberta de API (OpenAPI) + `control-adequacao` · P4

**Causa.** Sem `openapi.json`; `OPTIONS` devolve `Allow` vazio (default Hono);
rota base `/control-adequacao` sem handler (só `:phase/suggestions` e `apply`).

**Correção.**
1. Publicar `openapi.json` (gerar do Hono ou spec mínima curada).
2. Handler base para `/control-adequacao` (índice dos sub-paths) ou 404 documentado.

**Arquivos.** `src/index.ts`, `docs/`.

**Risco.** Baixo — DX, não bloqueia runtime.

---

## D6 — tela de governança · paralelo

Reconstrução (branch `feat/governance-redesign`): organograma com âncora do líder/DPO
no topo, áreas abaixo, superfície única, tiles de "adicionar" no lugar de caixas
vazias. Remove card aninhado e título triplicado. Guiado pelo `impeccable detect`.
