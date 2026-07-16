# SGSI-RACI-001: Funções e Responsabilidades do SGSI/SGPI — TWYN Face ID Platform
**ISO 27001:2022 Controle A.5.2 / Cláusula 5.3 | ISO 27701:2019 Cláusula 5.3**

---
**Document Control**
| Campo | Valor |
|-------|-------|
| **Document ID** | SGSI-RACI-001 |
| **Version** | 1.1 (Ajustado pós Auditoria Interna) |
| **Elaborado por** | Ricardo Esper (DPO & Consultor Perito) |
| **Aprovado por** | Kacio Lopes (CEO) |
| **Data de Publicação** | 16/07/2026 |
---

## 1. Descrição de Funções de Governança

### 1.1 CEO (Chief Executive Officer) — Kacio Lopes
*   **Papel**: Patrocinador Executivo e Aprovador do SGSI.
*   **Responsabilidades**:
    *   Prover os recursos financeiros e operacionais para a manutenção do SGSI.
    *   Aprovar formalmente as políticas corporativas de segurança da informação (ISP) e de privacidade.
    *   Liderar as reuniões anuais de Análise Crítica pela Direção (Cláusula 9.3).
    *   Aprovar o Plano de Tratamento de Riscos (RTP).

### 1.2 DPO & Consultor Perito (Data Protection Officer) — Ricardo Esper
*   **Papel**: Encarregado de Proteção de Dados e Consultor de Conformidade.
*   **Responsabilidades**:
    *   Atuar como canal de comunicação oficial entre a TWYN, os titulares de dados pessoais e a Autoridade Nacional de Proteção de Dados (ANPD).
    *   Conduzir e auditar os processos de adequação às normas ISO 27001 e ISO 27701.
    *   Elaborar e atualizar o Registro de Operações de Tratamento (ROPA).
    *   Coordenar as investigações de violações de privacidade e elaborar Relatórios de Impacto (DPIA/RIPD).
    *   Executar o planejamento de Auditorias Internas.

### 1.3 DevOps Cloud Lead — Augusto Ferronato
*   **Papel**: Líder de Infraestrutura e Segurança em Nuvem.
*   **Responsabilidades**:
    *   Garantir a segurança física-lógica e a configuração segura dos recursos hospedados na AWS.
    *   Gerenciar o ciclo de chaves criptográficas (AWS KMS), backup automatizado e disaster recovery.
    *   Controlar os direitos de acesso privilegiado (IAM/MFA) sob o princípio do menor privilégio.
    *   Implementar e zelar pelo pipeline seguro de CI/CD (controle de branches e PRs no GitHub).
    *   Monitorar logs de auditoria de infraestrutura (CloudTrail/CloudWatch).

### 1.4 SRE / DevOps Cloud — Augusto Ferronato (Backup)
*   **Papel**: Engenharia de Confiabilidade e Infraestrutura de Nuvem.
*   *Nota*: Augusto Ferronato acumula as funções de DevOps Cloud principal e SRE de infraestrutura, garantindo redundância nos procedimentos de backup/recovery.

### 1.5 CTO (Chief Technology Officer) — Nizar Elouaer
*   **Papel**: Diretor de Tecnologia e Segurança de Código.
*   **Responsabilidades**:
    *   Definir as diretrizes e padrões de desenvolvimento e codificação segura (OWASP).
    *   Aprovar as mudanças de arquitetura de software da API Face ID.
    *   Coordenar revisões de código de segurança (Peer Reviews) em conjunto com o time de engenharia.
    *   Garantir a validação e sanitização rígida de dados na entrada das APIs.

### 1.6 COO (Chief Operating Officer) — Rosa Correia
*   **Papel**: Segurança nas Operações e Pessoas (RH).
*   **Responsabilidades**:
    *   Garantir a assinatura deNDAs corporativos por todos os funcionários, consultores e parceiros.
    *   Coordenar as ações disciplinares em caso de violação de políticas de segurança.
    *   Gerenciar o processo formal de desligamento seguro (offboarding) de funcionários e parceiros.

### 1.7 CIO (Chief Identity Officer) — Bianca Lopes
*   **Papel**: Segurança de Identidades e Autenticação.
*   **Responsabilidades**:
    *   Gerenciar as chaves criptográficas de identidades e provedores de acesso (IdP/Auth0/Okta).
    *   Supervisionar a concessão e revogação trimestral de identidades e acessos aos sistemas da TWYN.

### 1.8 CFO (Chief Financial Officer) — Enes Degasperi
*   **Papel**: Segurança Financeira e Contratos de Terceiros.
*   **Responsabilidades**:
    *   Garantir cláusulas padrão de privacidade (DPAs) e acordos de confidencialidade (NDAs) em contratos com terceiros e fornecedores críticos.
    *   Assegurar orçamento anual para investimentos em licenças de segurança e treinamento.

### 1.9 CPO (Chief Product Officer) — Humberto Oliveira
*   **Papel**: Alinhamento de Produto com Privacy by Design.
*   **Responsabilidades**:
    *   Garantir que novos recursos da API Face ID sigam os princípios de minimização de dados e Privacy by Design desde a fase de conceito.

---

## 2. Matriz RACI do SGSI / SGPI

A Matriz RACI define os papéis envolvidos nas principais atividades do sistema de gestão:
*   **R** - Responsible (Quem executa a tarefa)
*   **A** - Accountable (Quem responde pela tarefa/aprova o resultado)
*   **C** - Consulted (Quem é consultado/aporta insumos)
*   **I** - Informed (Quem é informado sobre a conclusão)

| Processo / Atividade do SGSI | CEO (Kacio) | DPO/Perito (Ricardo) | DevOps (Augusto) | CTO (Nizar) | COO (Rosa) | Auditor Terceiro (Marcia) |
|------------------------------|-------------|-----------------------|------------------|-------------|------------|---------------------------|
| Aprovação de Políticas de SI | **A**       | **R**                 | **C**            | **C**       | **I**      | **I**                      |
| Análise e Tratamento de Risco| **A**       | **R**                 | **R**            | **C**       | **I**      | **I**                      |
| Segurança na AWS / IaC       | **I**       | **C**                 | **R** / **A**    | **C**       | **I**      | **I**                      |
| Codificação Segura (API)     | **I**       | **C**                 | **I**            | **R** / **A**| **I**      | **I**                      |
| Registro ROPA (Privacidade)  | **I**       | **R** / **A**         | **C**            | **I**       | **C**      | **I**                      |
| Resposta a Incidentes (ANPD) | **A**       | **R**                 | **R**            | **C**       | **C**      | **I**                      |
| Offboarding de Colaboradores | **I**       | **I**                 | **R**            | **I**       | **R** / **A**| **I**                      |
| Auditorias Internas          | **A**       | **C**                 | **C**            | **C**       | **I**      | **R**                      |
| Ações Corretivas (CAPAs)     | **I**       | **A**                 | **R**            | **R**       | **I**      | **C**                      |
