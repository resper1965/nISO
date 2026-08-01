# Technical Policies Suite — TWYN Face ID Platform
## Políticas Tecnológicas de Segurança (ISO 27001:2022 Controles A.8.24, A.8.25 e A.8.28)

Este documento reúne as três políticas de segurança obrigatórias para a certificação da API de Reconhecimento Facial da TWYN. Ricardo Esper (Bekaa) deve desmembrar este arquivo e comitar cada política na pasta `docs/02-policies/` do repositório da TWYN.

---

# 1. Política de Desenvolvimento Seguro (SDLC) — Controle A.8.25

### 1.1 Objetivo
Garantir que a segurança da informação seja projetada e implementada em todo o ciclo de vida de desenvolvimento de software (SDLC) da API da TWYN.

### 1.2 Diretrizes Técnicas
1. **Ambientes Segregados**: As atividades de desenvolvimento, teste e produção devem operar em contas AWS totalmente isoladas e redes (VPC) distintas. Dados de produção não devem ser copiados para desenvolvimento.
2. **Segurança por Design (Security by Design)**: Requisitos de segurança devem ser definidos no início de cada funcionalidade. Todo repositório Git de microsserviço deve possuir revisão de código obrigatória por no mínimo um engenheiro antes do merge (Pull Request).
3. **Automação de Varreduras (DevSecOps Pipeline)**:
   * **SAST (Static Application Security Testing)**: Rodar Semgrep ou SonarQube em cada commit para identificar código inseguro.
   * **SCA (Software Composition Analysis)**: Utilizar Dependabot ou Snyk para identificar dependências vulneráveis (CVEs).
4. **Gates de Qualidade (Quality Gates)**: O pipeline de CI/CD deve bloquear automaticamente deploys para homologação/produção se contiver vulnerabilidades de nível **High** ou **Critical** sem justificativa aprovada pelo SecOps.

---

# 2. Política de Codificação Segura (Secure Coding) — Controle A.8.28

### 2.1 Objetivo
Estabelecer as práticas obrigatórias de codificação para evitar a introdução de vulnerabilidades de injeção ou falhas de lógica nos endpoints da Face ID Platform.

### 2.2 Diretrizes Técnicas
1. **Proteção contra OWASP API Security Top 10**:
   * **Validação de Entrada (Input Validation)**: Todos os parâmetros de entrada (JSON payloads) no endpoint `/api/v1/verify` devem ser sanitizados e validados contra esquemas rígidos (Zod/Pydantic).
   * **Rate Limiting**: Aplicar limites de taxa (Rate Limiting) baseados em IP e API Key para evitar ataques de força bruta e negação de serviço (DoS).
2. **Tratamento de Dados Biométricos (LGPD)**:
   * **Volatilidade de Imagens**: Imagens faciais enviadas para autenticação por liveness devem ser armazenadas apenas em memória RAM (volátil) ou em disco efêmero e excluídas imediatamente após a conclusão da validação (máximo de 5 minutos).
   * **Tokenização de Templates**: O vetor biométrico resultante (face template) deve ser criptografado e armazenado sem conter dados identificadores diretos (PII) do usuário final (desassociação lógica).
3. **Prevenção de Logs Inseguros**:
   * **Log Scrubbing**: O middleware de logging deve possuir filtros Regex para ofuscar chaves de API, chaves privadas e dados biométricos sensíveis, impedindo sua gravação em plaintext nos logs do CloudWatch ou Datadog.

---

# 3. Política de Uso de Criptografia — Controle A.8.24

### 3.1 Objetivo
Definir as regras para o uso de chaves criptográficas e algoritmos para proteger a confidencialidade e integridade dos dados trafegados e armazenados pela TWYN.

### 3.2 Diretrizes Técnicas
1. **Criptografia em Trânsito**:
   * **TLS 1.3 Obrigatório**: Toda a comunicação externa com a API Face ID deve usar HTTPS TLS 1.3. Conexões TLS 1.1 ou inferiores devem ser ativamente rejeitadas pelo Application Load Balancer (ALB).
   * **HSTS (HTTP Strict Transport Security)**: Habilitar o cabeçalho HSTS em todas as respostas da API para forçar conexões seguras.
2. **Criptografia em Repouso**:
   * **Armazenamento de Dados**: Todos os bancos de dados (RDS Aurora PostgreSQL), vetores de reconhecimento (Vector Index) e buckets S3 devem utilizar criptografia AES-256 baseada em chaves gerenciadas no **AWS KMS**.
   * **Hashing de API Keys**: Chaves de API de clientes devem ser armazenadas no banco de dados nISO/D1 apenas sob a forma de hash criptográfico forte (SHA-256 com salting).
3. **Gestão de Chaves Criptográficas (KMS)**:
   * **Rotação de Chaves**: A rotação automática anual deve ser ativada para todas as chaves mestras de cliente (CMK) gerenciadas no AWS KMS.
   * **Controle de Acesso**: O acesso para alterar políticas de chaves KMS deve ser restrito exclusivamente ao perfil do DevOps Lead, auditado via AWS CloudTrail.

---

# 4. Política de Gestão de Identidades e SSO (IAM) — Controle A.5.16

**Document ID:** POL-IAM-002 | **Classification:** Internal | **Version:** 1.0

### 4.1 Objetivo
Garantir o controle centralizado de identidades digitais para todos os colaboradores da TWYN no acesso a ferramentas SaaS operacionais e administrativas.

### 4.2 Diretrizes de SSO e Controle de Acesso
1. **SSO Centralizado**: O acesso a ferramentas SaaS corporativas (como Slack, GitHub, Datadog e AWS) deve ser obrigatoriamente autenticado através de um provedor de identidade centralizado (IdP - ex: Okta ou Auth0).
2. **Ciclo de Vida de Identidades**: Toda criação, alteração ou revogação de acessos deve ser solicitada formalmente ao CIO Bianca Lopes, com revogação executada em no máximo 2 horas após a demissão ou desligamento do colaborador.

### 4.3 Complexidade de Credenciais e Autenticação (Controle A.5.17)
1. **Padrão de Senhas**: Qualquer senha de acesso ao IdP centralizado deve possuir no mínimo 14 caracteres, incluindo letras maiúsculas, minúsculas, números e caracteres especiais.
2. **Uso de Cofre de Senhas**: Fica proibido o armazenamento de senhas em plaintext. É obrigatória a utilização do cofre de senhas corporativo (1Password/AWS Secrets Manager) para guarda e compartilhamento seguro de credenciais administrativas.
3. **Bloqueio Automático**: Sistemas de acesso administrativo devem impor bloqueio após 5 tentativas de login incorretas e exigir MFA (Multi-Factor Authentication).

### 4.4 Gerenciamento e Revisão de Direitos de Acesso (Controle A.5.18)
1. **Concessão sob Demanda**: Acessos lógicos adicionais a repositórios Git ou contas AWS devem ser concedidos apenas sob aprovação escrita da CISO Bianca Lopes.
2. **Revisões Periódicas de Acessos**: A cada 6 meses, a CISO deve realizar uma auditoria completa de acessos concedidos nas contas AWS e ferramentas SaaS, revogando imediatamente acessos não utilizados ou excessivos.

### 4.5 Restrição de Acesso a Informações (Controle A.8.3)
1. **Princípio do Menor Privilégio**: O acesso a dados biométricos sensíveis e de clientes no RDS PostgreSQL deve ser restrito exclusivamente às chamadas automatizadas da API Face ID.
2. **RBAC (Role-Based Access Control)**: Engenheiros e operadores possuem acessos limitados baseados em suas funções técnicas declaradas na Matriz RACI.

### 4.6 Restrição de Acesso a Código-Fonte (Controle A.8.4)
1. **Acesso sob Necessidade de Trabalho**: O acesso de escrita e visualização aos repositórios do código-fonte da Face ID Platform no GitHub deve ser restrito a desenvolvedores autorizados.
2. **Proteção de Branches**: As branches `main` e `prod` devem possuir regras rígidas de branch protection (exigência de pull request assinado por no mínimo um segundo revisor de código e testes do CI/CD verdes).

# 5. Manual de Configuração Segura (Hardening) — Controle A.8.9

**Document ID:** SOP-HDN-001 | **Classification:** Internal | **Version:** 1.0

### 5.1 Objetivo
Estabelecer os padrões mínimos de configuração segura (hardening) para os ativos de processamento de nuvem da TWYN.

### 5.2 Hardening de Instâncias EC2/EKS e RDS
1. **Hardening de Sistemas Operacionais**: Instâncias de servidores EC2 e nós do EKS devem adotar imagens mínimas oficiais (ex: Bottlerocket ou Amazon Linux Minimal) e desativar qualquer serviço, porta ou protocolo desnecessário.
2. **Hardening de Banco de Dados RDS**:
   * Desativar a opção `Publicly Accessible` nas propriedades do banco RDS Aurora.
   * Utilizar criptografia baseada em chaves KMS dedicadas.
   * Ativar o registro detalhado de conexões e auditar consultas de banco de dados via AWS CloudWatch Logs.

# 6. Requisitos de Segurança de Aplicação — Controle A.8.26

**Document ID:** POL-APP-001 | **Classification:** Internal | **Version:** 1.0

### 6.1 Objetivo
Garantir que os requisitos de segurança da informação e privacidade sejam formalmente identificados e aplicados durante a fase de especificação do desenvolvimento da API Face ID.

### 6.2 Especificação de Requisitos de Segurança
1. **Requisitos de Negócio e Engenharia**: Toda nova funcionalidade de processamento de imagem ou template de face deve especificar no respectivo ticket (Jira/GitHub Issues) os seguintes requisitos de segurança:
   * Tipo de dados pessoais tratados e a respectiva salvaguarda.
   * Controles de criptografia em trânsito e repouso.
   * Padrão de autenticação exigido no endpoint correspondente.
2. **Aprovação**: O CTO Nizar Elouaer é o responsável por auditar e assinar a validação desses requisitos antes do início do ciclo de sprints de desenvolvimento.

# 7. Manual de Arquitetura e Engenharia Segura — Controle A.8.14 e A.8.27

**Document ID:** SOP-ARC-001 | **Classification:** Internal | **Version:** 1.0

### 7.1 Princípios de Engenharia e Arquitetura Segura (A.8.27)
1. **Zero Trust nas APIs**: Toda requisição à API Face ID deve validar o token JWT de autenticação em todas as etapas internas (microsserviços segregados).
2. **Segurança por Padrão (Secure by Default)**: Portas de acesso e permissões de IAM padrão devem ser de negação total (implicit deny).
3. **Desacoplamento Sensível**: O template facial biométrico e os metadados cadastrais do cliente B2B devem ser armazenados em bancos de dados distintos, com associação apenas via UUID criptográfico (desacoplamento lógico).

### 7.2 Redundância de Facilidades de Processamento (A.8.14)
1. **Alta Disponibilidade AWS**: A API Face ID opera em cluster Amazon EKS distribuído em no mínimo 3 Zonas de Disponibilidade (Availability Zones).
2. **Replicação RDS Aurora**: O banco de dados opera em modo Multi-AZ, com failover automatizado para réplica de leitura síncrona em caso de falha física do nó primário.

# 8. Política de Transferência Segura de Informações — Controle A.5.14

**Document ID:** POL-TX-001 | **Classification:** Internal | **Version:** 1.0

### 8.1 Diretrizes de Transferência Segura
1. **Protocolos Seguros**: Qualquer transferência de arquivos sensíveis (dados de configuração, chaves públicas, logs) deve ocorrer sobre canais criptografados e protegidos (HTTPS/SFTP).
2. **Proibição de plaintext**: Fica expressamente proibido o compartilhamento de API Keys, chaves privadas ou imagens faciais biométricas por e-mail corporativo ou chats abertos de uso cotidiano (Slack/Whatsapp).

## 9. Controle de Documento e Aprovações

| Versão | Data de Revisão | Descrição do Ajuste | Autor | Aprovado por |
|--------|-----------------|---------------------|-------|--------------|
| 1.0    | 16/07/2026      | Criação e versionamento inicial | Ricardo Esper (DPO) | Kacio Lopes (CEO) |
| 1.1    | 16/07/2026      | Inclusão de IAM/SSO, Hardening e Requisitos de Aplicação | Ricardo Esper (DPO) | Kacio Lopes (CEO) |
| 1.2    | 16/07/2026      | Inclusão de Arquitetura Segura, Redundância e Transferências | Ricardo Esper (DPO) | Kacio Lopes (CEO) |

---
**Status:** Approved | **Data da Próxima Revisão:** 16/07/2027
