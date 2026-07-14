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
