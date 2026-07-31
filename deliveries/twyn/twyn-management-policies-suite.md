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

### 1.4 Workflow de Resposta a Incidentes (Controle A.5.26)
O comitê CSIRT deve seguir as 5 fases obrigatórias de resposta a incidentes:
1. **Triagem e Análise**: Confirmar se o evento constitui um incidente real de segurança, avaliar a severidade (P0-P3) e registrar no log interno do CSIRT.
2. **Contenção**: Executar o bloqueio imediato do vetor de ataque (ex: revogação de acessos via AWS IAM, isolamento de subredes).
3. **Erradicação**: Identificar e eliminar a causa raiz (ex: remoção de malware, correção de vulnerabilidades em código ou configuração).
4. **Recuperação e Restabelecimento**: Restaurar os serviços a partir de backups limpos e monitorar tráfego para confirmar a estabilidade.
5. **Pós-Mortem e Aprendizado**: Elaborar relatório detalhado de lições aprendidas em até 5 dias úteis, atualizando controles do SGSI para prevenir recorrência.

### 1.5 Procedimento de Contato com Autoridades (Controle A.5.5)
O DPO Ricardo Esper mantém a matriz oficial de contatos de autoridades externas para notificações rápidas:
1. **ANPD (Autoridade Nacional de Proteção de Dados)**: Notificação via peticionamento eletrônico no portal Gov.br (SLA de 2 dias úteis para incidentes envolvendo PII biométrica).
2. **Autoridades Policiais / Polícia Civil (Cibercrimes)**: Registro de Boletim de Ocorrência imediato em caso de intrusão externa maliciosa.
3. **Órgãos Reguladores Financeiros (se aplicável)**: Notificação a clientes B2B do setor financeiro para cumprimento de normas do Banco Central do Brasil.

### 1.6 Contato com Grupos Especiais de Interesse (Controle A.5.6)
A TWYN mantém participação ativa e canais de comunicação com grupos de segurança para compartilhamento de inteligência de ameaças:
1. **CERT.br (Centro de Estudos, Resposta e Tratamento de Incidentes de Segurança no Brasil)**: Envio de relatórios de incidentes ou tentativas de intrusão para cooperação em escala nacional.
2. **ISC2 / ANPPD**: Participação e consulta técnica ativa dos profissionais de segurança do time para atualização de melhores práticas regulatórias e de segurança lógica.

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

# 5. Política de Classificação e Proteção de Registros (DCP) — Controles A.5.12, A.5.13 e A.5.33

**Document ID:** POL-DCP-001 | **Classification:** Internal | **Version:** 1.0

### 5.1 Objetivo
Definir as regras para classificação, rotulagem e retenção segura de dados biométricos sensíveis e de negócios na Face ID Platform, garantindo a conformidade regulatória.

### 5.2 Diretrizes de Classificação e Rotulagem (A.5.12, A.5.13)
1. **Classificação de Informações**: As informações tratadas pela TWYN são classificadas em quatro níveis de criticidade:
   * **Pública**: Informações de marketing e documentação pública da API.
   * **Uso Interno**: Comunicações internas e processos operacionais de rotina.
   * **Confidencial**: Código-fonte da API, logs de infraestrutura e diagramas de rede.
   * **Altamente Confidencial (Sensível)**: Hashes de templates biométricos e chaves mestras de criptografia KMS.
2. **Rotulagem de Dados (Labelling)**: Todo documento do SGSI/SGPI e repositório Git deve conter metadados e marcas textuais que identifiquem explicitamente sua classificação. Dados Altamente Confidenciais biométricos devem possuir tags específicas na base de dados (`DataClassification = PII_Sensitive`).

### 5.3 Retenção e Proteção de Registros (A.5.33)
1. **Período de Retenção**:
   * Hashes biométricos de produção (Templates): Retidos durante a vigência do contrato comercial com o cliente B2B parceiro, devendo ser eliminados em até 15 dias após o término da relação ou solicitação de exclusão do titular.
   * Logs de Auditoria (CloudTrail/D1 access): Retidos por 1 ano para fins de auditoria de conformidade.
2. **Descarte Seguro**: A eliminação de dados de produção biométricos deve ser realizada via expurgo lógico definitivo na base de dados com sobrescrita criptográfica (exclusão lógica e destruição de chaves de acesso), gerando logs de deleção.

---

# 6. Política de Segurança em Fornecedores (VMP) — Controles A.5.21 e A.5.22

**Document ID:** POL-VMP-002 | **Classification:** Internal | **Version:** 1.0

### 6.1 Objetivo
Garantir que a segurança da informação e privacidade de dados da TWYN sejam mantidas na contratação e gestão de serviços de fornecedores e parceiros de TIC (Tecnologia da Informação e Comunicação).

### 6.2 Diligência e Gestão de Fornecedores (A.5.21)
1. **Formulário de Qualificação (KYV)**: Todos os fornecedores críticos de infraestrutura (provedores SaaS, cloud, serviços de e-mail e mensageria) devem passar por qualificação prévia de segurança, respondendo ao questionário KYV (Know Your Vendor).
2. **Requisitos Mínimos**: São priorizados fornecedores de TIC certificados na norma ISO/IEC 27001 ou que possuam relatório SOC 2 Tipo II vigente.

### 6.3 Monitoramento e Auditoria de Contratos (A.5.22)
1. **Revisões Periódicas**: O CFO Enes Degasperi deve revisar anualmente os contratos de fornecedores de TIC para verificar a manutenção dos Acordos de Nível de Serviço (SLAs) e das cláusulas de privacidade (DPA).
2. **Direito a Auditoria**: Contratos com parceiros e terceirizados de desenvolvimento devem prever o direito da TWYN de conduzir auditorias de segurança lógica amostrais nos processos integrados.

---

# 7. Política de Segurança em Recursos Humanos — Controle A.5.11, A.6.5 e A.6.6

**Document ID:** POL-HR-001 | **Classification:** Internal | **Version:** 1.0

### 7.1 Devolução de Ativos (A.5.11)
Todos os colaboradores e terceiros que encerrarem seu vínculo com a TWYN devem devolver todos os ativos da empresa sob sua posse (notebooks, tokens, chaves criptográficas e mídias de armazenamento) em até 2 dias úteis após o encerramento do contrato.

### 7.2 Responsabilidades após o Término (A.6.5)
1. **Checklist de Offboarding**: O RH deve conduzir um checklist de desligamento formal, garantindo que o DevOps Cloud revogue todas as credenciais e acessos lógicos (SSO, AWS, e-mail) do colaborador desligado em até 2 horas úteis da rescisão.
2. **Revisão de Sigilo**: Deve ser realizada entrevista de desligamento formalizando os deveres de sigilo contínuos sobre dados biométricos sensíveis de que o colaborador teve ciência.

### 7.3 Termos de Confidencialidade e NDAs (A.6.6)
É obrigatória a assinatura de Acordos de Confidencialidade (NDAs) por todos os funcionários, prestadores de serviço e desenvolvedores terceirizados no momento de sua integração à empresa (onboarding), com validade de no mínimo 5 anos pós-desligamento.

---

# 8. Política de Governança Gerencial e Projetos — Controle A.5.4 e A.5.8

**Document ID:** POL-GOV-001 | **Classification:** Internal | **Version:** 1.0

### 8.1 Responsabilidades da Direção (A.5.4)
1. **Suporte Ativo**: A gerência executiva da TWYN (CEO, CFO e CTO) deve apoiar ativamente o SGSI/SGPI, garantindo recursos financeiros e infraestrutura física e lógica para a manutenção dos controles de segurança.
2. **Revisões Trimestrais**: O comitê de segurança deve se reunir trimestralmente para revisar incidentes, riscos e aprovar novas diretivas.

### 8.2 Segurança em Gestão de Projetos (A.5.8)
A segurança da informação deve ser integrada formalmente ao ciclo de vida de qualquer projeto de desenvolvimento ou melhoria da API Face ID:
* Todo projeto no Jira deve conter uma subtask de avaliação de impactos à segurança e privacidade de dados pessoais biométricos.
* Alterações de arquitetura na AWS devem possuir aprovação prévia em termos de compliance antes do provisionamento.

---

## 9. Controle de Documento e Aprovações

| Versão | Data de Revisão | Descrição do Ajuste | Autor | Aprovado por |
|--------|-----------------|---------------------|-------|--------------|
| 1.0    | 16/07/2026      | Criação e assinatura do comitê | Ricardo Esper (DPO) | Kacio Lopes (CEO) |
| 1.1    | 16/07/2026      | Inclusão das políticas de Classificação de Dados e Fornecedores | Ricardo Esper (DPO) | Kacio Lopes (CEO) |
| 1.2    | 16/07/2026      | Inclusão de políticas de RH, IRP expandida e Governança | Ricardo Esper (DPO) | Kacio Lopes (CEO) |

---
**Status:** Approved | **Data da Próxima Revisão:** 16/07/2027
