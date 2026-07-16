# SGSI-INV-001: Inventário de Informação Documentada Mandatória (ISO 27001:2022) — TWYN
**Mapeamento de Existência e Localização dos Entregáveis do SGSI/SGPI**

---
**Controle de Documento**
| Campo | Valor |
|-------|-------|
| **Document ID** | SGSI-INV-001 |
| **Version** | 1.0 (Auditoria Preliminar) |
| **Responsável** | Ricardo Esper (DPO & Consultor Perito) |
| **Foco** | API de Face ID |
---

## 1. Inventário de Documentos Mandatórios (Cláusulas 4 a 10)

Para a certificação oficial do SGSI, o auditor externo avaliará a existência e a eficácia de 15 pilares de informação documentada mandatórios. Abaixo está o mapeamento de sua existência física no workspace ou de sua persistência baseada em dados (data-driven) no banco nISO (D1 de produção):

| # | Documento Mandatório | Ref. Norma | Status de Existência | Localização / Evidência no nISO |
|---|----------------------|------------|-----------------------|---------------------------------|
| **1** | Escopo do SGSI | Cláusula 4.3 | **Existente (Asset)** | Template `/templates/policies/v2022/isms-scope.md` publicado e instanciado. |
| **2** | Política de Segurança (ISP) | Cláusula 5.2 | **Existente (Físico/BD)** | Cadastrado como `ctrl-a51` (Approved) e rascunhado em `isms-policy.md`. |
| **3** | Metodologia de Avaliação de Riscos | Cláusula 6.1.2| **Existente (Físico)** | Descrita na Seção 2 do arquivo `risk-register-reconstructed.md`. |
| **4** | Resultados da Avaliação de Riscos | Cláusula 8.2 | **Existente (Físico/BD)** | Tabela `risks` no D1 remoto + `risk-register-reconstructed.md`. |
| **5** | Plano de Tratamento de Riscos (RTP) | Cláusula 6.1.3| **Existente (Físico/BD)** | Ações de mitigação salvas na tabela `risks` + mitigação descrita em risks. |
| **6** | Declaração de Aplicabilidade (SoA) | Cláusula 6.1.3d| **Existente (Físico/BD)** | Tabela `compliance_controls` no D1 remoto + `statement-of-applicability-reconstructed.md`. |
| **7** | Objetivos de Segurança da Informação | Cláusula 6.2 | **Existente (BD)** | Definidos nas métricas da tabela `performance_metrics` no D1 remoto. |
| **8** | Evidência de Competência | Cláusula 7.2 | **Existente (BD)** | Registros de conscientização e treinamento salvos na tabela `training_records`. |
| **9** | Controle de Informação Documentada | Cláusula 7.5 | **Existente (Asset)** | Regras de versionamento e aprovação definidas no `sgsi-raci-001-twyn.md`. |
| **10** | Planejamento e Controle Operacional | Cláusula 8.1 | **Existente (BD)** | As 41 fases do projeto e checklists persistidos na tabela `checklist_progress`. |
| **11** | Resultados do Tratamento de Riscos | Cláusula 8.3 | **Existente (BD)** | Evidências técnicas de mitigação anexadas aos controles da tabela `evidence`. |
| **12** | Monitoramento e Medição (KPIs) | Cláusula 9.1 | **Existente (BD)** | Acompanhamento do complianceRate no dashboard + logs de auditoria na tabela `audit_logs`. |
| **13** | Resultados de Auditoria Interna | Cláusula 9.2 | **Existente (BD)** | Cadastros de achados (NCs) populados na tabela `audit_findings` e `audit_schedule`. |
| **14** | Resultados de Análise Crítica | Cláusula 9.3 | **Existente (BD)** | Pauta e decisões de reunião salvas na tabela `management_reviews`. |
| **15** | Não Conformidades e CAPAs | Cláusula 10.1 | **Existente (BD)** | Planos de ação de desvios registrados na tabela `corrective_actions`. |

---

## 2. Inventário de Políticas Técnicas da API (Controles de Engenharia)

Além dos documentos de governança organizacionais, a API da TWYN possui as seguintes políticas técnicas implementadas e assinadas pelo DPO (Ricardo Esper) e CEO (Kacio Lopes):

*   **Política de Desenvolvimento Seguro (Controle A.8.25)**:
    *   *Localização*: `twyn-technical-policies-suite.md` (Seção 1) + cadastrado em `ctrl-a825` (Approved).
*   **Política de Codificação Segura (Controle A.8.28)**:
    *   *Localização*: `twyn-technical-policies-suite.md` (Seção 2) + cadastrado em `ctrl-a828` (Approved).
*   **Política de Criptografia (Controle A.8.24)**:
    *   *Localização*: `twyn-technical-policies-suite.md` (Seção 3) + cadastrado em `ctrl-a824` (Approved).

---

## 3. Considerações do Auditor (Conformidade Digital)
O SGSI da TWYN adota uma arquitetura **100% digital e orientada a dados**. A lista mestra de documentos mandatórios não reside em arquivos isolados em pastas de rede (passíveis de fraude ou desatualização cronológica), mas é gerida ativamente no D1 remoto de produção, auditável em tempo real. Esta característica é considerada uma **Força de Engenharia** para a auditoria de Estágio 1.
