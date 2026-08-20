# Avaliação de segurança — OWASP Top 10 (2021) + RFC 9116

Revisão da aplicação nISO (Workers/Hono/D1) contra o OWASP Top 10:2021 e a
disponibilidade de `security.txt`. Baseada em leitura do código (`src/`), não em
pentest dinâmico. Legenda: ✅ adequado · ⚠️ gap/hardening · 🔴 corrigir.

## Resumo

O app já é endurecido: `secureHeaders` (HSTS + CSP restritiva), CORS, rate-limit,
PBKDF2 salgado com comparação em tempo constante, MFA/TOTP, isolamento de tenant,
log estruturado + trilha de auditoria, e `security.txt` (RFC 9116) já publicado.

Achados abertos: **1 🔴** (token em texto claro — já é o D1/P1 do backlog) e **4 ⚠️**
de hardening. Nenhuma injeção SQL (queries parametrizadas) nem XSS óbvio (escape no
frontend) encontrados.

| OWASP | Situação | Item |
|-------|----------|------|
| A01 Broken Access Control | ✅ | isolamento por `requireResourceAccess` (endurecido no #107) |
| A02 Cryptographic Failures | 🔴 ⚠️ | S1 token texto claro · S4 senha legada SHA-256 |
| A03 Injection | ✅ | queries parametrizadas (`.bind`); `escapeHTML` no front |
| A04 Insecure Design | ✅ | rate-limit por custo, invalidação de aprovação por integridade |
| A05 Security Misconfiguration | ⚠️ | S2 CSP `unsafe-inline` · S3 CORS `*` |
| A06 Vulnerable Components | ⚠️ | S5 rodar `npm audit` no CI |
| A07 Auth Failures | ✅ ⚠️ | PBKDF2 100k + MFA · S6 login rate-limit só por IP |
| A08 Integrity Failures | ✅ | CI + deploy versionado; sem desserialização insegura |
| A09 Logging & Monitoring | ✅ | log JSON por request + `logAudit` (sem PII) |
| A10 SSRF | ✅ | sem fetch a URL controlada por usuário no core |

## security.txt (RFC 9116) — ✅

`GET /.well-known/security.txt` já servido em `src/index.ts`. Correto:
`Contact` (e-mail + advisory), `Expires` **calculado** (180 d — não vence esquecido),
`Canonical`, `Policy` → `SECURITY.md` (presente), `Preferred-Languages`. Nada a fazer.

---

## Achados

### S1 · Token do repositório em texto claro no D1 — 🔴 (A02)
`projects.repository_token` gravado em claro. O #107 redigiu na resposta; falta cifrar
em repouso. **Já é o D1/P1** em `backlog-plan.md` (AES-GCM + secret + migração).

### S2 · CSP com `script-src 'unsafe-inline'` — ⚠️ (A05/A03)
Concessão consciente (~324 `onclick=` inline). Enquanto durar, o CSP não barra XSS
injetado; o valor vem de `object-src/base-uri/form-action/frame-ancestors 'none'` e do
`escapeHTML`. **Upgrade:** migrar `onclick` → `addEventListener` e trocar por `nonce`.

### S3 · CORS `origin: '*'` — ⚠️ (A05)
Risco real baixo (auth por Bearer em `localStorage`, sem cookies → sem CSRF por
credencial). Ainda assim, restringir aos domínios conhecidos (app + preview) reduz
superfície e permite endurecer `allowHeaders`. **Ação:** allowlist de origens.

### S4 · Caminho legado de senha SHA-256 sem sal — ⚠️ (A02/A07)
`verifyPassword` aceita hashes antigos sem `:` como SHA-256 de rodada única, sem sal —
hash rápido, vulnerável a rainbow/GPU. Comparação é em tempo constante (bom).
**Ação:** re-hash para PBKDF2 no próximo login bem-sucedido e remover o ramo legado
depois de migrar a base.

### S5 · Sem `npm audit` no CI — ⚠️ (A06)
Não há gate de vulnerabilidade de dependência. **Ação:** `npm audit --audit-level=high`
(root + frontend + mcp-server) como passo do CI, não bloqueante no início.

### S6 · Login rate-limit só por IP — ⚠️ (A07)
`login:<ip>` 20/5min. Um escritório inteiro compartilha o teto (falso positivo) e um
ataque distribuído numa conta não é freado por conta. **Ação:** somar limite por
conta-alvo (`login:acct:<email>`) e considerar apertar a janela.

---

## Ordem sugerida

**S1** (já P1) → **S5** (rápido, cobre risco desconhecido) → **S4** → **S6** → **S3** → **S2** (maior, depende de refactor de front).
