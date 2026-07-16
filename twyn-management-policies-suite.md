# Management Policies Suite — TWYN Face ID Platform
## Políticas Organizacionais e de Gestão (ISO 27001:2022 Controles A.5.24, A.5.34, A.8.32 e A.8.8)

Este documento reúne as quatro políticas de gestão obrigatórias para a certificação do SGSI/SGPI da TWYN. O DPO & Consultor Perito (Ricardo Esper) e o DevOps Cloud (Augusto Ferronato) devem implementar e zelar pela execução prática de cada uma delas.

---

# 1. Política de Resposta a Incidentes (IRP) — Controle A.5.24

**Document ID:** POL-IRP-001 | **Classification:** Internal | **Version:** 1.0

### 1.1 Objetivo (ISO 27001 Annex A.5.24 a A.5.28)
Garantir uma resposta rápida, coordenada e eficaz a incidentes de segurança da informação e privacidade na Face ID Platform, minimizando danos operacionais, financeiros e de reputação.

### 1.2 Comitê de Resposta a Incidentes (CSIRT)
Fica constituído o comitê permanente de resposta com os seguintes papéis:
*   **Coordenador do CSIRT & DPO**: Ricardo Esper (responsável pela gestão regulatória, forense e comunicação legal).
*   **Líder Técnico de Contenção**: Augusto Ferronato - DevOps Cloud (responsável pelo isolamento técnico de instâncias AWS/EKS e restauração de sistemas).
*   **Patrocinador Executivo**: Kacio Lopes - CEO (responsável por autorizações de paradas de serviço e decisões de crise).

### 1.3 Diretrizes de Resposta e Notificação ANPD
1.  **Identificação e Registro**: Qualquer colaborador que identificar um evento de segurança (ex: chaves expostas, acessos anômalos no CloudTrail) deve reportar imediatamente ao CSIRT.
2.  **Contenção Imediata**: O DevOps Cloud (Augusto Ferronato) deve isolar recursos afetados, revogar chaves comprometidas e rotacionar credenciais sob o protocolo de menor privilégio.
3.  **Classificação de Severidade**:
    *   **P0/P1 (Crítico/Alto)**: Vazamento de chaves mestras KMS, hashes biométricos de produção comprometidos ou indisponibilidade total da API.
    *   **P2/P3 (Médio/Baixo)**: Vulnerabilidades internas descobertas em dependências ou falhas parciais em sandbox.
4.  **Notificação ANPD em 2 Dias Úteis**: Em caso de incidentes P0/P1 que envolvam risco ou danos relevantes aos direitos dos titulares de dados pessoais, o DPO Ricardo Esper deve formalizar a notificação à ANPD em até 2 dias úteis da ciência do fato.

---

# 2. Política de Proteção de Dados e Privacidade (DPP) — Controle A.5.34

**Document ID:** POL-DPP-001 | **Classification:** Internal | **Version:** 1.0

### 2.1 Objetivo (ISO 27001 Annex A.5.34 / ISO 27701)
Estabelecer as diretrizes para a proteção de Dados Pessoais Sensíveis Biométricos e salvaguardas de privacidade no processamento da API da TWYN, sob a égide da LGPD.

### 2.2 Tratamento de Dados Biométricos (Face ID)
1.  **Pseudoanonimização (Hashes Tratados)**: A TWYN não armazena dados cadastrais diretos de titulares (como Nome, CPF ou RG) vinculados a templates faciais. O vetor biométrico de face (template) é gerado na forma de hash matemático irreversível associado a um ID interno pseudoanônimo.
2.  **Volatilidade Rígida**: Fotos cruas coletadas temporariamente dos usuários para análise de liveness (verificação de vivacidade) devem ser processadas em memória volátil e **eliminadas em até 5 minutos** após a conclusão do ciclo de validação.
3.  **Bases Legais**: Todas as transações da API operam sob a base legal de **Consentimento** do titular final (coletado na interface do cliente B2B parceiro) ou sob **Prevenção à Fraude e Segurança do Titular** (LGPD Art. 11, II, "g").

### 2.3 Gestão de Direitos dos Titulares
1.  O DPO Ricardo Esper é o encarregado exclusivo de monitorar as solicitações de direitos de titulares (confirmação, exclusão de dados biométricos pseudoanonimizados ou revogação de consentimento).
2.  O DevOps Cloud Augusto Ferronato deve prover o suporte técnico para a exclusão definitiva dos hashes associados ao ID solicitado dos servidores AWS em até 15 dias úteis, gerando logs de auditoria da remoção.

---

# 3. Política de Gestão de Mudanças (CMP) — Controle A.8.32

**Document ID:** POL-CMP-001 | **Classification:** Internal | **Version:** 1.0

### 3.1 Objetivo (ISO 27001 Annex A.8.32)
Garantir que todas as alterações no código-fonte da API, bancos de dados e infraestrutura em nuvem da TWYN sejam planejadas, autorizadas, testadas e implementadas de forma segura.

### 3.2 Processo Pragmático de Mudança (PonyTail Workflow)
1.  **Desenvolvimento Isolado**: Nenhuma alteração é efetuada diretamente no ambiente de produção. Desenvolvedores trabalham em ramificações (branches) isoladas no Git.
2.  **Revisão por Pares (Peer Review)**: Todo Pull Request (PR) deve passar obrigatoriamente pela validação e aprovação escrita de no mínimo um segundo desenvolvedor sênior da equipe antes de qualquer merge.
3.  **Hardening de Branch**: A branch principal (`main`/`prod`) do repositório GitHub deve ser ativamente protegida contra envios (pushes) diretos.
4.  **Implantação via IaC**: Mudanças em rede (VPCs, Security Groups) e infraestrutura de produção da AWS devem ser propostas como Infraestrutura como Código (Terraform) e aplicadas exclusivamente pelo DevOps Cloud Augusto Ferronato, auditadas via logs.
5.  **Plano de Rollback**: Toda mudança estrutural de banco de dados ou deploy de grande porte deve conter um plano de rollback documentado e testado em sandbox.

---

# 4. Política de Gestão de Vulnerabilidades (VMP) — Controle A.8.8

**Document ID:** POL-VMP-001 | **Classification:** Internal | **Version:** 1.0

### 4.1 Objetivo (ISO 27001 Annex A.8.8)
Mitigar os riscos decorrentes de vulnerabilidades técnicas em sistemas operacionais, dependências de software e serviços em nuvem AWS associados à API Face ID.

### 4.2 Diretrizes de Monitoramento e Correção
1.  **Varreduras de Dependências (SCA)**: O repositório de código da TWYN deve possuir a ferramenta Github Dependabot ativada para monitorar passivamente vulnerabilidades conhecidas (CVEs) em bibliotecas e dependências de terceiros.
2.  **Segurança em Nuvem**: O DevOps Cloud Augusto Ferronato deve manter ativos e monitorados os alertas do **AWS GuardDuty** (detecção de ameaças) e **AWS Trusted Advisor** (configurações inseguras).
3.  **Prazos de Correção (SLA)**:
    *   **Vulnerabilidades Critical / High**: Devem ser mitigadas ou corrigidas em produção em até **15 dias** da ciência do fato.
    *   **Vulnerabilidades Medium / Low**: Devem ser tratadas em até **90 dias** ou em ciclos programados de refatoração de sprint.
4.  **Exceções e Aceite de Risco**: Em caso de falso-positivo de scanners ou impossibilidade técnica de upgrade de bibliotecas, o DPO Ricardo Esper e o CEO Kacio Lopes devem formalizar o aceite temporário de risco justificado no Registro de Riscos.

---

## 5. Controle de Documento e Aprovações

| Versão | Data de Revisão | Descrição do Ajuste | Autor | Aprovado por |
|--------|-----------------|---------------------|-------|--------------|
| 1.0    | 16/07/2026      | Criação e assinatura do comitê | Ricardo Esper (DPO) | Kacio Lopes (CEO) |

---
**Status:** Approved | **Data da Próxima Revisão:** 16/07/2027
