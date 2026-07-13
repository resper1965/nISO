-- ═══════════════════════════════════════════════
-- Seed Consolidado: TWYN ISO 27001:2022
-- Espelho exato da produção (remote D1)
-- ═══════════════════════════════════════════════

-- 0. Usuário admin
INSERT INTO users (id, email, password_hash, role, name) VALUES
('admin', 'admin@ness.io', '$2a$10$placeholder', 'admin', 'Admin ness.')
ON CONFLICT(id) DO NOTHING;

-- 1. Projeto TWYN (ID real de produção)
INSERT INTO projects (id, project_name, client_name, sector, scope, standards, org_role, status, created_at) VALUES
('mr9c1qugo16zic2eko', 'TWYN Face ID Platform', 'TWYN (Bekaa Trusted Advisors)', 'Technology / Biometrics', 'Face ID Platform API + AWS Infrastructure', 'ISO 27001:2022, ISO 27701:2019', 'Operator', 'Audit Ready', '2026-05-20 10:00:00')
ON CONFLICT(id) DO UPDATE SET
  project_name = excluded.project_name,
  client_name = excluded.client_name,
  sector = excluded.sector,
  scope = excluded.scope,
  standards = excluded.standards,
  status = excluded.status;

-- 2. 41 Fases (IDs e status reais de produção)
INSERT INTO project_phases (id, project_id, phase_number, title, status) VALUES
('mr9c1qygum0q35hgsa',     'mr9c1qugo16zic2eko', 0,  'Mobilização e Mandato',           'completed'),
('mr9c1qygbso4iblp1zf',    'mr9c1qugo16zic2eko', 1,  'Entrevista Executiva',             'completed'),
('mr9c1qygni5z1a94q8',     'mr9c1qugo16zic2eko', 2,  'Entrevistas por Trilha',           'completed'),
('mr9c1qyghbcw2qh6a96',    'mr9c1qugo16zic2eko', 3,  'Definição de Escopo',              'completed'),
('mr9c1qygzvwi1ltq3',      'mr9c1qugo16zic2eko', 4,  'Gap Assessment',                   'completed'),
('mr9c1qyg0z95ycluwvwe',   'mr9c1qugo16zic2eko', 5,  'Governança e Papéis',              'completed'),
('mr9c1qygsijj5dog3sq',    'mr9c1qugo16zic2eko', 6,  'Contexto e Partes Interessadas',   'completed'),
('mr9c1qygxscjfvy8qdf',    'mr9c1qugo16zic2eko', 7,  'Inventário de Ativos e Dados',     'completed'),
('mr9c1qyg0z9h1j7vbb6',    'mr9c1qugo16zic2eko', 8,  'Mapeamento de Processos',          'completed'),
('mr9c1qygotweql79naq',     'mr9c1qugo16zic2eko', 9,  'Riscos de Segurança',              'completed'),
('mr9c1qyg6imi62bc6zv',    'mr9c1qugo16zic2eko', 10, 'Riscos de Privacidade',            'completed'),
('mr9c1qygzjuui504wlh',    'mr9c1qugo16zic2eko', 11, 'Tratamento de Riscos',             'completed'),
('mr9c1qygqbvtqk5dy9',     'mr9c1qugo16zic2eko', 12, 'SoA do SGSI',                      'completed'),
('mr9c1qyg8xej49raqqf',    'mr9c1qugo16zic2eko', 13, 'SoA do SGPI',                      'completed'),
('mr9c1qygl1rq5d932w',     'mr9c1qugo16zic2eko', 14, 'Arquitetura Documental',           'completed'),
('mr9c1qygwiv32il12ss',    'mr9c1qugo16zic2eko', 15, 'Controles Organizacionais',        'in_progress'),
('mr9c1qygo24pjfqqf5',     'mr9c1qugo16zic2eko', 16, 'Controles de Pessoas',             'in_progress'),
('mr9c1qyg5thlyr5z6sk',    'mr9c1qugo16zic2eko', 17, 'Controles Físicos',                'in_progress'),
('mr9c1qyg1lp1zs9t0u6',    'mr9c1qugo16zic2eko', 18, 'Controles Tecnológicos',           'in_progress'),
('mr9c1qyg6vamukhg117',    'mr9c1qugo16zic2eko', 19, 'Desenvolvimento Seguro',           'in_progress'),
('mr9c1qyghl22cwk6tej',    'mr9c1qugo16zic2eko', 20, 'Cloud, DevOps e SRE',              'in_progress'),
('mr9c1qyg4snag96tw3r',    'mr9c1qugo16zic2eko', 21, 'Programa de Privacidade',          'in_progress'),
('mr9c1qygn4ll59u79ek',    'mr9c1qugo16zic2eko', 22, 'Privacy by Design',                'in_progress'),
('mr9c1qygp7etb0se65l',    'mr9c1qugo16zic2eko', 23, 'Direitos dos Titulares',           'in_progress'),
('mr9c1qyggvro1j0xl46',    'mr9c1qugo16zic2eko', 24, 'Consentimento e Bases Legais',     'in_progress'),
('mr9c1qyg6mbz8wct8qm',    'mr9c1qugo16zic2eko', 25, 'Retenção e Descarte',              'in_progress'),
('mr9c1qygz2ozyd42z8i',    'mr9c1qugo16zic2eko', 26, 'Transferências e Compartilhamento','in_progress'),
('mr9c1qygdyfjr4tzhi8',    'mr9c1qugo16zic2eko', 27, 'Fornecedores e Operadores',        'in_progress'),
('mr9c1qygh9uyoyuoj1u',    'mr9c1qugo16zic2eko', 28, 'Incidentes',                       'in_progress'),
('mr9c1qygfhh424zk1qq',    'mr9c1qugo16zic2eko', 29, 'Treinamento',                      'in_progress'),
('mr9c1qyggwlt1m3iyzh',    'mr9c1qugo16zic2eko', 30, 'Monitoramento e Métricas',         'in_progress'),
('mr9c1qyg2ilcy79abxy',    'mr9c1qugo16zic2eko', 31, 'Auditoria Interna',                'completed'),
('mr9c1qygqqgtgaqvjuf',    'mr9c1qugo16zic2eko', 32, 'Análise Crítica',                  'completed'),
('mr9c1qyg0skxolx5w6qi',   'mr9c1qugo16zic2eko', 33, 'Melhoria Contínua',               'pending'),
('mr9c1qygbzhaf8qjt9',     'mr9c1qugo16zic2eko', 34, 'Certificação Estágio 1',           'pending'),
('mr9c1qygtz18lsslwso',    'mr9c1qugo16zic2eko', 35, 'Certificação Estágio 2',           'pending'),
('mr9c1qygkysz26g97h8',    'mr9c1qugo16zic2eko', 36, 'Pós-Certificação',                 'pending'),
('mr9c1qyghzch6w677wq',    'mr9c1qugo16zic2eko', 37, 'Gestão de Vulnerabilidades',       'pending'),
('mr9c1qyg7q4n62sr406',    'mr9c1qugo16zic2eko', 38, 'Continuidade de Negócios',         'pending'),
('mr9c1qyg2qgnzwcwd11',    'mr9c1qugo16zic2eko', 39, 'Segurança Física',                 'pending'),
('mr9c1qygwcslmznkb0c',    'mr9c1qugo16zic2eko', 40, 'Encerramento do Ciclo',            'pending')
ON CONFLICT(id) DO UPDATE SET status = excluded.status;

-- 3. Controles SoA
INSERT INTO compliance_controls (id, project_id, standard, title, description, status, maturity, owner) VALUES
('ctrl-a51',       'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.5.1 Policies for information security', 'SGSI-POLICY-001 aprovada mas aguardando assinatura formal do CEO.', 'Implemented', 1, 'CISO'),
('ctrl-a59',       'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.5.9 Inventory of information and other associated assets', 'An inventory of information and other associated assets, including owners, shall be developed and maintained.', 'Implemented', 3, 'IT Manager'),
('ctrl-a815',      'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.8.15 Logging', 'Monitoramento contínuo via AWS CloudTrail e GuardDuty.', 'Implemented', 4, 'DevOps'),
('ctrl-a517',      'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.5.17 Authentication information', 'AWS Secrets Manager (SOP-004). Chave tmpsaasboost não rotacionada.', 'Partial', 2, 'DevOps'),
('ctrl-a530',      'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.5.30 ICT readiness for business continuity', 'BCP Elaborado. RTO: 4 horas, RPO: 1 hora. Restore RDS testado em sandbox.', 'Partial', 1, 'IT Manager'),
('ctrl-a526',      'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.5.26 Response to information security incidents', 'IRP necessita formalização prática de runbooks.', 'Partial', 2, 'CISO'),
('ctrl-a822',      'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.8.22 Segregation of networks', 'Segregação de redes via VPC e Security Groups (SOP-004).', 'Implemented', 3, 'DevOps'),
('asset-info-001', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'Biometric Data (Face Embeddings)', 'Classificação: CRITICAL. Local: S3 twyn-biometric-data (AES-256).', 'Implemented', 4, 'DevOps Lead'),
('asset-info-004', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'AWS IAM Credentials', 'Classificação: CRITICAL. Local: Secrets Manager e .env files (legacy - RISCO).', 'Partial', 2, 'DevOps Lead'),
('asset-infra-003','mr9c1qugo16zic2eko', 'ISO 27001:2022', 'EKS Cluster (twyn-faceid-prod)', 'Kubernetes cluster executando Face ID Platform API em us-east-1.', 'Implemented', 4, 'DevOps Lead'),
('asset-infra-009','mr9c1qugo16zic2eko', 'ISO 27001:2022', 'AWS Config', 'Serviço de compliance. Status: Parcial (FTR Blocker).', 'Partial', 1, 'DevOps Lead')
ON CONFLICT(id) DO UPDATE SET status = excluded.status, maturity = excluded.maturity, description = excluded.description;

-- 4. Evidências
INSERT INTO evidence (id, control_id, project_id, file_name, r2_key, file_hash, file_type, uploaded_by, created_at) VALUES
('ev-twyn-scope',  'ctrl-a51', 'mr9c1qugo16zic2eko', 'SGSI-SCOPE-001 - ISMS Scope.md', 'twyn/scope.md', 'sha256-b8a9c8d7e6f5...', 'text/markdown', 'consultant@ness.io', '2026-05-26 10:00:00'),
('ev-twyn-policy', 'ctrl-a51', 'mr9c1qugo16zic2eko', 'SGSI-POLICY-001 - Information Security Policy.md', 'twyn/policy.md', 'sha256-a1b2c3d4e5f6...', 'text/markdown', 'consultant@ness.io', '2026-05-26 11:30:00')
ON CONFLICT(id) DO NOTHING;

-- 5. Riscos
INSERT INTO risks (id, project_id, asset, threat, vulnerability, impact, probability, risk_level, treatment, status) VALUES
('risk-twyn-01', 'mr9c1qugo16zic2eko', 'Face ID API', 'Acesso não autorizado', 'MFA não obrigatório em todos os endpoints', 5, 2, 'High', 'Mitigate', 'Open'),
('risk-twyn-02', 'mr9c1qugo16zic2eko', 'AWS RDS', 'Vazamento de Dados Biométricos', 'Criptografia em repouso não validada', 5, 1, 'Medium', 'Mitigate', 'Open'),
('risk-twyn-03', 'mr9c1qugo16zic2eko', 'Bucket R2', 'Exposição acidental de logs', 'Políticas de bucket permissivas', 4, 3, 'High', 'Mitigate', 'Open'),
('risk-twyn-04', 'mr9c1qugo16zic2eko', 'AWS IAM Credentials', 'Vazamento de Chaves Privadas', 'Uso de .env files legados', 5, 4, 'Critical', 'Mitigate', 'Open'),
('risk-twyn-05', 'mr9c1qugo16zic2eko', 'AWS Config', 'Não Conformidade com AWS FTR', 'AWS Config não plenamente operacional', 3, 4, 'Medium', 'Mitigate', 'Open'),
('risk-twyn-06', 'mr9c1qugo16zic2eko', 'S3 Biometric Buckets', 'Biometric data breach (S3 misconfig)', 'Public access possible, lack of encryption', 5, 5, 'Critical', 'Mitigate', 'Open'),
('risk-twyn-07', 'mr9c1qugo16zic2eko', 'AWS Root Account', 'Unauthorized root access', 'Root used for daily ops, key stored insecurely', 5, 4, 'Critical', 'Mitigate', 'Open'),
('risk-twyn-08', 'mr9c1qugo16zic2eko', 'EKS Clusters', 'Ransomware attack', 'Cluster monitoring gaps, unpatched nodes', 5, 4, 'Critical', 'Mitigate', 'Open'),
('risk-twyn-09', 'mr9c1qugo16zic2eko', 'IAM Policies', 'IAM Over-permissioning (Insider)', 'Many users with AdministratorAccess', 4, 4, 'High', 'Mitigate', 'Open'),
('risk-twyn-10', 'mr9c1qugo16zic2eko', 'AWS Account', 'Lack of Threat Detection', 'No GuardDuty active', 5, 3, 'High', 'Mitigate', 'Open')
ON CONFLICT(id) DO NOTHING;

-- 6. Fornecedores
INSERT INTO vendors (id, project_id, name, category, trust_score, status) VALUES
('vendor-aws',    'mr9c1qugo16zic2eko', 'Amazon Web Services (AWS)', 'Cloud Infrastructure', 95, 'Approved'),
('vendor-github', 'mr9c1qugo16zic2eko', 'GitHub', 'Source Code Management', 92, 'Approved'),
('vendor-linear', 'mr9c1qugo16zic2eko', 'Linear', 'Project Management', 88, 'Approved')
ON CONFLICT(id) DO NOTHING;

-- 7. Treinamento
INSERT INTO training_records (id, project_id, employee_name, training_name, completion_date, status, score) VALUES
('train-01', 'mr9c1qugo16zic2eko', 'Kacio Lopes', 'Governança SGSI para Liderança', '2026-06-20', 'Completed', 100),
('train-02', 'mr9c1qugo16zic2eko', 'Rosa Correia', 'Operações e Compliance ISO 27001', '2026-06-21', 'Completed', 95),
('train-03', 'mr9c1qugo16zic2eko', 'Humberto Oliveira', 'Privacidade e Proteção de Dados Biométricos', '2026-06-22', 'Completed', 98)
ON CONFLICT(id) DO NOTHING;

-- 8. Calendário de Auditoria
INSERT INTO audit_schedule (id, project_id, audit_type, title, scheduled_date, auditor_name, status) VALUES
('audit-01', 'mr9c1qugo16zic2eko', 'Internal', 'Auditoria Interna Ciclo 1', '2026-08-15', 'Consultor ness. Sênior', 'Planned'),
('audit-02', 'mr9c1qugo16zic2eko', 'External', 'Auditoria de Certificação (Stage 1)', '2026-09-20', 'Organismo Certificador (TUV/BSI)', 'Planned')
ON CONFLICT(id) DO NOTHING;

-- 9. Ações Corretivas (CAPA)
INSERT INTO corrective_actions (id, project_id, title, description, root_cause, action_plan, status, severity) VALUES
('capa-01', 'mr9c1qugo16zic2eko', 'Rotação de Credenciais Críticas', 'Chave tmpsaasboost no Secrets Manager não rotacionada há mais de 90 dias.', 'Processo manual sem automação', 'Implementar Lambda para rotação automática e atualizar SOP-004.', 'Open', 'Critical'),
('capa-02', 'mr9c1qugo16zic2eko', 'Execução de Teste de Disaster Recovery', 'Testes de restore de backup nunca realizados.', 'Priorização em features', 'Agendar e executar teste de restore do RDS em staging.', 'Open', 'High'),
('capa-03', 'mr9c1qugo16zic2eko', 'Contradição de Continuidade', 'Política prevê restore semanal, mas Risk Register informa testes nunca executados.', 'Falha operacional vs política escrita', 'Realizar teste de DR imediato.', 'Open', 'High')
ON CONFLICT(id) DO NOTHING;

-- 10. Audit Logs
INSERT INTO audit_logs (id, action, actor, details, created_at) VALUES
('alog-01', 'Review', 'admin', 'Revisão do Escopo do SGSI: Aprovado sem ressalvas.', '2026-06-10 14:00:00'),
('alog-02', 'Review', 'admin', 'Política de SI: Necessita assinatura do CEO.', '2026-06-10 15:30:00'),
('alog-03', 'Approval', 'admin', 'Controle A.5.1 validado com base na política SGSI-POLICY-001.', '2026-07-06 10:00:00')
ON CONFLICT(id) DO NOTHING;

-- 11. Chat History (simulação)
INSERT INTO ai_chat_history (id, project_id, user_id, role, content, created_at) VALUES
('chat-01', 'mr9c1qugo16zic2eko', 'admin', 'user', 'Qual o escopo atual da certificação TWYN?', '2026-05-26 09:00:00'),
('chat-02', 'mr9c1qugo16zic2eko', 'admin', 'assistant', 'O escopo do SGSI da TWYN abrange a Face ID Platform API e toda a infraestrutura AWS associada, conforme definido no documento SGSI-SCOPE-001.', '2026-07-06 09:00:05')
ON CONFLICT(id) DO NOTHING;
