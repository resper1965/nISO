# Changelog
All notable changes to this project will be documented in this file.

## [Não publicado] - 2026-09
### Added
- **Handoff ness. (`niso-handoff-v1`)**: tokens do design system, shell (sidebar 232/72, bandas de 64px, menu de conta), primitivas de `ui.js` (cabeçalho sem subtítulo, badge por `color-mix`, tabela com cabeçalho fixo, toast com Desfazer e região `aria-live` permanente).
- **Gate de aplicabilidade N/A da SoA**: justificativa obrigatória na tela e no servidor (`recusaAplicabilidade` em `routes/controls.ts`, `assertSoAExportable` em `services/soa-logic.ts`); marcar N/A zera CMMI e dono; a SoA não é produzida com exclusão sem justificativa.
- **SoA**: ordenação natural do código do Anexo A, seleção em lote com Desfazer, cursor de teclado (`j`/`k`/`Enter`/`x`/`a`), skeleton, estados de erro com código de requisição e paginação explícita de 25.
- **Autenticação (conta local)**: erro de credencial genérico com tentativas restantes, desafio anti-abuso a partir da 2ª falha, bloqueio de 15 min com `auth.lockout`, expiração por inatividade (30 min Cliente / 8 h consultor), segundo fator de 6 dígitos que valida ao completar, reautenticação preservando rascunho e trilha da própria sessão.
- **Documentos legais versionados** (migration 0024): classificação `comum | material`; material barra o acesso até o aceite, registrado com data, IP e user-agent.
- **Trilha por campo** (migration 0025): `campo: antes → depois` com autor e `operation_id` que agrupa o lote; histórico exibido no detalhe do controle.

### Changed
- Paleta iOS (`#34c759`/`#ffcc00`/`#ff3b30`) → paleta ness. (`#10b981`/`#f59e0b`/`#ef4444`); `--text-dim` deixa de ser alpha (estava em ≈3,4:1 sobre o card) e passa a `#94a3b8`.
- `--glass-blur: none` remove todos os `backdrop-filter` herdados.

### Fixed
- `PUT /api/v1/controls/:id/status` aceitava marcar N/A sem justificativa nenhuma, contornando o gate da tela.
- `forceCloseModal()` lançava quando os elementos de modal não existiam, matando a cascata de Esc.

## [8.0.0] - 2026-07-03
### Added
- **Sprint 8**: Certification Tracker, AI Compliance Assistant (Llama 3.1), Onboarding Status, Template Marketplace, Public Endpoints (Pricing/Stats), and Landing Page.
- **Sprint 7**: Webhooks, API Keys (SHA-256), and CSV Exports.
- **Sprint 6**: Executive Report, Portfolio view, Audit Calendar, and CAPA (Corrective Actions).
- **Sprint 5**: Policy Templates (10 ISO templates), Traceability (Risk -> Control -> Evidence), ROPA Module, Gap Analysis, and Control Maturity (CMM).
- **Sprint 4**: Risk Assessment Module, KYV (Know Your Vendor), Security Awareness Tracker, Bulk Policy Generation, and ISO 27701 Migration.
- **Sprint 3**: Evidence Upload (R2 + SHA-256), MemoryService (Vectorize RAG), SoA Logic Engine (93 rules), and Audit Readiness Pack.
- **Sprint 2**: PolicyAgent (AI Policy Gen), EvidenceAgent (AI Evidence Eval), Auditor Portal, and Notification System.
- **Sprint 1**: Assessment Pre-Sales, Pricing Engine, Auto-Proposal, Auto-Project, Phase Checklists, and UI/UX Redesign (Glassmorphism).

## [1.0.0] - 2026-07-02
### Added
- Initial project structure and constitution.
- Basic Hono API setup on Cloudflare Workers.
- Database schema and D1 integration.
