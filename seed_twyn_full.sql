PRAGMA foreign_keys = OFF;

-- ═══════════════════════════════════════════════
-- Seed Consolidado GRC & Conformidade: TWYN ISO 27001:2022
-- ═══════════════════════════════════════════════

-- Limpeza idempotente dos dados antigos da TWYN
DELETE FROM ai_chat_history WHERE project_id = 'mr9c1qugo16zic2eko';
DELETE FROM audit_logs WHERE details LIKE '%mr9c1qugo16zic2eko%' OR action = 'Review';
DELETE FROM auditor_notes WHERE project_id = 'mr9c1qugo16zic2eko';
DELETE FROM context_analysis WHERE project_id = 'mr9c1qugo16zic2eko';
DELETE FROM stakeholders WHERE project_id = 'mr9c1qugo16zic2eko';
DELETE FROM corrective_actions WHERE project_id = 'mr9c1qugo16zic2eko';
DELETE FROM audit_schedule WHERE project_id = 'mr9c1qugo16zic2eko';
DELETE FROM training_records WHERE project_id = 'mr9c1qugo16zic2eko';
DELETE FROM vendors WHERE project_id = 'mr9c1qugo16zic2eko';
DELETE FROM risks WHERE project_id = 'mr9c1qugo16zic2eko';
DELETE FROM evidence WHERE project_id = 'mr9c1qugo16zic2eko';
DELETE FROM assets WHERE project_id = 'mr9c1qugo16zic2eko';
DELETE FROM compliance_controls WHERE project_id = 'mr9c1qugo16zic2eko';
DELETE FROM checklist_progress WHERE project_id = 'mr9c1qugo16zic2eko';
DELETE FROM project_phases WHERE project_id = 'mr9c1qugo16zic2eko';
DELETE FROM projects WHERE id = 'mr9c1qugo16zic2eko';

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
('mr9c1qygotweql79naq',    'mr9c1qugo16zic2eko', 9,  'Riscos de Segurança',              'completed'),
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
('mr9c1qyg2ilcy79abxy',    'mr9c1qugo16zic2eko', 31, 'Auditoria Interna',                'pending'),
('mr9c1qygqqgtgaqvjuf',    'mr9c1qugo16zic2eko', 32, 'Análise Crítica',                  'pending'),
('mr9c1qyg0skxolx5w6qi',   'mr9c1qugo16zic2eko', 33, 'Melhoria Contínua',               'pending'),
('mr9c1qygbzhaf8qjt9',     'mr9c1qugo16zic2eko', 34, 'Certificação Estágio 1',           'pending'),
('mr9c1qygtz18lsslwso',    'mr9c1qugo16zic2eko', 35, 'Certificação Estágio 2',           'pending'),
('mr9c1qygkysz26g97h8',    'mr9c1qugo16zic2eko', 36, 'Pós-Certificação',                 'pending'),
('mr9c1qyghzch6w677wq',    'mr9c1qugo16zic2eko', 37, 'Gestão de Vulnerabilidades',       'pending'),
('mr9c1qyg7q4n62sr406',    'mr9c1qugo16zic2eko', 38, 'Continuidade de Negócios',         'pending'),
('mr9c1qyg2qgnzwcwd11',    'mr9c1qugo16zic2eko', 39, 'Segurança Física',                 'pending'),
('mr9c1qygwcslmznkb0c',    'mr9c1qugo16zic2eko', 40, 'Encerramento do Ciclo',            'pending')
ON CONFLICT(id) DO UPDATE SET status = excluded.status;

-- 3. Todos os 93 Controles SoA da TWYN
INSERT INTO compliance_controls (id, project_id, standard, title, description, status, maturity, owner) VALUES
('ctrl-a51', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.5.1 Policies for information security', 'Universal ISMS requirement.', 'Missing', 0, 'CISO'),
('ctrl-a52', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.5.2 Information security roles and responsibilities', 'Required for clear accountability.', 'Missing', 0, 'CISO'),
('ctrl-a53', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.5.3 Segregation of duties', 'Prevents fraud and error through duty separation.', 'Missing', 0, 'CISO'),
('ctrl-a54', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.5.4 Management responsibilities', 'Management commitment is foundational to ISMS.', 'Missing', 0, 'CISO'),
('ctrl-a55', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.5.5 Contact with authorities', 'Required for incident reporting and compliance.', 'Missing', 0, 'CISO'),
('ctrl-a56', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.5.6 Contact with special interest groups', 'Threat intelligence and best practice sharing.', 'Missing', 0, 'CISO'),
('ctrl-a57', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.5.7 Threat intelligence', 'Proactive threat awareness is universally beneficial.', 'Missing', 0, 'CISO'),
('ctrl-a58', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.5.8 Information security in project management', 'Security must be embedded in all projects.', 'Missing', 0, 'CISO'),
('ctrl-a59', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.5.9 Inventory of information and other associated assets', 'Asset inventory is foundational to risk management.', 'Missing', 0, 'CISO'),
('ctrl-a510', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.5.10 Acceptable use of information and other associated assets', 'Defines acceptable behavior for all personnel.', 'Missing', 0, 'CISO'),
('ctrl-a511', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.5.11 Return of assets', 'Required for personnel offboarding.', 'Missing', 0, 'CISO'),
('ctrl-a512', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.5.12 Classification of information', 'Data classification drives proportional protection.', 'Missing', 0, 'CISO'),
('ctrl-a513', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.5.13 Labelling of information', 'Labelling supports classification enforcement.', 'Missing', 0, 'CISO'),
('ctrl-a514', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.5.14 Information transfer', 'All organizations transfer information externally.', 'Missing', 0, 'CISO'),
('ctrl-a515', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.5.15 Access control', 'Logical access control is universally required.', 'Missing', 0, 'CISO'),
('ctrl-a516', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.5.16 Identity management', 'Unique identity for accountability.', 'Missing', 0, 'CISO'),
('ctrl-a517', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.5.17 Authentication information', 'Credential management is universally required.', 'Missing', 0, 'CISO'),
('ctrl-a518', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.5.18 Access rights', 'Provisioning and review of access rights.', 'Missing', 0, 'CISO'),
('ctrl-a519', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.5.19 Information security in supplier relationships', 'Third-party/vendor relationships identified.', 'Missing', 0, 'CISO'),
('ctrl-a520', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.5.20 Addressing information security within supplier agreements', 'Contractual security clauses needed for suppliers.', 'Missing', 0, 'CISO'),
('ctrl-a521', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.5.21 Managing information security in the ICT supply chain', 'ICT supply chain risks identified.', 'Missing', 0, 'CISO'),
('ctrl-a522', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.5.22 Monitoring, review and change management of supplier services', 'Ongoing supplier oversight required.', 'Missing', 0, 'CISO'),
('ctrl-a523', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.5.23 Information security for use of cloud services', 'Cloud infrastructure in use.', 'Missing', 0, 'CISO'),
('ctrl-a524', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.5.24 Information security incident management planning and preparation', 'Incident preparedness is universal.', 'Missing', 0, 'CISO'),
('ctrl-a525', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.5.25 Assessment and decision on information security events', 'Event triage process required.', 'Missing', 0, 'CISO'),
('ctrl-a526', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.5.26 Response to information security incidents', 'Incident response capability required.', 'Missing', 0, 'CISO'),
('ctrl-a527', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.5.27 Learning from information security incidents', 'Continuous improvement from incidents.', 'Missing', 0, 'CISO'),
('ctrl-a528', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.5.28 Collection of evidence', 'Evidence preservation for investigations.', 'Missing', 0, 'CISO'),
('ctrl-a529', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.5.29 Information security during disruption', 'Security continuity during disruptions.', 'Missing', 0, 'CISO'),
('ctrl-a530', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.5.30 ICT readiness for business continuity', 'ICT continuity planning is universally needed.', 'Missing', 0, 'CISO'),
('ctrl-a531', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.5.31 Legal, statutory, regulatory and contractual requirements', 'Compliance obligations exist for all organizations.', 'Missing', 0, 'CISO'),
('ctrl-a532', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.5.32 Intellectual property rights', 'IP protection applies to all organizations.', 'Missing', 0, 'CISO'),
('ctrl-a533', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.5.33 Protection of records', 'Record retention and protection required.', 'Missing', 0, 'CISO'),
('ctrl-a534', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.5.34 Privacy and protection of PII', 'PII processing identified — privacy controls mandatory.', 'Missing', 0, 'CISO'),
('ctrl-a535', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.5.35 Independent review of information security', 'Independent assurance is an ISMS requirement.', 'Missing', 0, 'CISO'),
('ctrl-a536', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.5.36 Compliance with policies, rules and standards for information security', 'Compliance verification is universal.', 'Missing', 0, 'CISO'),
('ctrl-a537', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.5.37 Documented operating procedures', 'Operational procedures must be documented.', 'Missing', 0, 'CISO'),
('ctrl-a61', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.6.1 Screening', 'Background verification for all personnel.', 'Missing', 0, 'CISO'),
('ctrl-a62', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.6.2 Terms and conditions of employment', 'Security responsibilities in employment contracts.', 'Missing', 0, 'CISO'),
('ctrl-a63', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.6.3 Information security awareness, education and training', 'Security awareness is universal.', 'Missing', 0, 'CISO'),
('ctrl-a64', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.6.4 Disciplinary process', 'Consequences for policy violations.', 'Missing', 0, 'CISO'),
('ctrl-a65', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.6.5 Responsibilities after termination or change of employment', 'Post-employment obligations required.', 'Missing', 0, 'CISO'),
('ctrl-a66', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.6.6 Confidentiality or non-disclosure agreements', 'NDAs protect sensitive information.', 'Missing', 0, 'CISO'),
('ctrl-a67', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.6.7 Remote working', 'Remote work arrangements identified.', 'Missing', 0, 'CISO'),
('ctrl-a68', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.6.8 Information security event reporting', 'All personnel must be able to report events.', 'Missing', 0, 'CISO'),
('ctrl-a71', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.7.1 Physical security perimeters', 'Physical office/facility identified.', 'Missing', 0, 'CISO'),
('ctrl-a72', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.7.2 Physical entry', 'Physical access control needed for premises.', 'Missing', 0, 'CISO'),
('ctrl-a73', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.7.3 Securing offices, rooms and facilities', 'Physical spaces require securing.', 'Missing', 0, 'CISO'),
('ctrl-a74', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.7.4 Physical security monitoring', 'Monitoring of physical premises required.', 'Missing', 0, 'CISO'),
('ctrl-a75', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.7.5 Protecting against physical and environmental threats', 'Environmental protection for facilities.', 'Missing', 0, 'CISO'),
('ctrl-a76', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.7.6 Working in secure areas', 'Secure area procedures for sensitive operations.', 'Missing', 0, 'CISO'),
('ctrl-a77', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.7.7 Clear desk and clear screen', 'Applies to all workstations including remote.', 'Missing', 0, 'CISO'),
('ctrl-a78', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.7.8 Equipment siting and protection', 'Equipment in physical premises needs protection.', 'Missing', 0, 'CISO'),
('ctrl-a79', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.7.9 Security of assets off-premises', 'Assets used outside premises require protection.', 'Missing', 0, 'CISO'),
('ctrl-a710', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.7.10 Storage media', 'Media handling applies to all organizations.', 'Missing', 0, 'CISO'),
('ctrl-a711', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.7.11 Supporting utilities', 'Power/cooling for on-premise infrastructure.', 'Missing', 0, 'CISO'),
('ctrl-a712', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.7.12 Cabling security', 'Physical cabling in premises.', 'Missing', 0, 'CISO'),
('ctrl-a713', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.7.13 Equipment maintenance', 'All equipment requires maintenance.', 'Missing', 0, 'CISO'),
('ctrl-a714', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.7.14 Secure disposal or re-use of equipment', 'Secure disposal applies universally.', 'Missing', 0, 'CISO'),
('ctrl-a81', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.8.1 User endpoint devices', 'Endpoint security is universally required.', 'Missing', 0, 'CISO'),
('ctrl-a82', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.8.2 Privileged access rights', 'Privileged access management is universal.', 'Missing', 0, 'CISO'),
('ctrl-a83', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.8.3 Information access restriction', 'Need-to-know access restriction.', 'Missing', 0, 'CISO'),
('ctrl-a84', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.8.4 Access to source code', 'Source code access control for development teams.', 'Missing', 0, 'CISO'),
('ctrl-a85', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.8.5 Secure authentication', 'Secure authentication is universal.', 'Missing', 0, 'CISO'),
('ctrl-a86', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.8.6 Capacity management', 'Resource capacity planning is universal.', 'Missing', 0, 'CISO'),
('ctrl-a87', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.8.7 Protection against malware', 'Malware protection is universally required.', 'Missing', 0, 'CISO'),
('ctrl-a88', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.8.8 Management of technical vulnerabilities', 'Vulnerability management is universal.', 'Missing', 0, 'CISO'),
('ctrl-a89', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.8.9 Configuration management', 'Secure configuration baselines required.', 'Missing', 0, 'CISO'),
('ctrl-a810', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.8.10 Information deletion', 'Data lifecycle management is universal.', 'Missing', 0, 'CISO'),
('ctrl-a811', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.8.11 Data masking', 'Sensitive/PII data requires masking in non-production.', 'Missing', 0, 'CISO'),
('ctrl-a812', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.8.12 Data leakage prevention', 'DLP needed for sensitive/regulated data.', 'Missing', 0, 'CISO'),
('ctrl-a813', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.8.13 Information backup', 'Backup is universally required.', 'Missing', 0, 'CISO'),
('ctrl-a814', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.8.14 Redundancy of information processing facilities', 'Critical/regulated operations require redundancy.', 'Missing', 0, 'CISO'),
('ctrl-a815', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.8.15 Logging', 'Activity logging is universal.', 'Missing', 0, 'CISO'),
('ctrl-a816', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.8.16 Monitoring activities', 'Security monitoring is universal.', 'Missing', 0, 'CISO'),
('ctrl-a817', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.8.17 Clock synchronization', 'Time synchronization for log correlation.', 'Missing', 0, 'CISO'),
('ctrl-a818', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.8.18 Use of privileged utility programs', 'Restricting privileged utilities is universal.', 'Missing', 0, 'CISO'),
('ctrl-a819', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.8.19 Installation of software on operational systems', 'Software installation controls are universal.', 'Missing', 0, 'CISO'),
('ctrl-a820', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.8.20 Networks security', 'Network security is universally required.', 'Missing', 0, 'CISO'),
('ctrl-a821', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.8.21 Security of network services', 'Network service security is universal.', 'Missing', 0, 'CISO'),
('ctrl-a822', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.8.22 Segregation of networks', 'Network segmentation for sensitive environments.', 'Missing', 0, 'CISO'),
('ctrl-a823', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.8.23 Web filtering', 'Fully remote workforce — web filtering deferred to endpoint controls.', 'Not Applicable', 0, 'CISO'),
('ctrl-a824', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.8.24 Use of cryptography', 'Cryptography for data protection is universal.', 'Missing', 0, 'CISO'),
('ctrl-a825', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.8.25 Secure development life cycle', 'SDLC security for in-house development.', 'Missing', 0, 'CISO'),
('ctrl-a826', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.8.26 Application security requirements', 'Application security requirements for dev/web apps.', 'Missing', 0, 'CISO'),
('ctrl-a827', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.8.27 Secure system architecture and engineering principles', 'Secure architecture for systems in scope.', 'Missing', 0, 'CISO'),
('ctrl-a828', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.8.28 Secure coding', 'Secure coding standards for development teams.', 'Missing', 0, 'CISO'),
('ctrl-a829', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.8.29 Security testing in development and acceptance', 'Security testing in SDLC.', 'Missing', 0, 'CISO'),
('ctrl-a830', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.8.30 Outsourced development', 'Outsourced development relationships identified.', 'Missing', 0, 'CISO'),
('ctrl-a831', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.8.31 Separation of development, test and production environments', 'Environment separation for development teams.', 'Missing', 0, 'CISO'),
('ctrl-a832', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.8.32 Change management', 'Change management is universal.', 'Missing', 0, 'CISO'),
('ctrl-a833', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.8.33 Test information', 'Test data protection for development activities.', 'Missing', 0, 'CISO'),
('ctrl-a834', 'mr9c1qugo16zic2eko', 'ISO 27001:2022', 'A.8.34 Protection of information systems during audit testing', 'Audit testing safeguards are universal.', 'Missing', 0, 'CISO')
ON CONFLICT(id) DO NOTHING;

-- 4. Atualizar controles específicos implementados ou parciais na TWYN
UPDATE compliance_controls SET status = 'Implemented', maturity = 2, owner = 'CISO', description = 'SGSI-POLICY-001 aprovada mas aguardando assinatura formal do CEO.' WHERE id = 'ctrl-a51';
UPDATE compliance_controls SET status = 'Implemented', maturity = 3, owner = 'IT Manager', description = 'Inventário de ativos migrado para a tabela assets dedicada.' WHERE id = 'ctrl-a59';
UPDATE compliance_controls SET status = 'Implemented', maturity = 4, owner = 'DevOps', description = 'Monitoramento contínuo via AWS CloudTrail e GuardDuty.' WHERE id = 'ctrl-a815';
UPDATE compliance_controls SET status = 'Partial', maturity = 2, owner = 'DevOps', description = 'AWS Secrets Manager (SOP-004). Chave tmpsaasboost não rotacionada.' WHERE id = 'ctrl-a517';
UPDATE compliance_controls SET status = 'Partial', maturity = 1, owner = 'IT Manager', description = 'BCP Elaborado. RTO: 4 horas, RPO: 1 hora. Restore RDS testado em sandbox.' WHERE id = 'ctrl-a530';
UPDATE compliance_controls SET status = 'Partial', maturity = 2, owner = 'CISO', description = 'IRP necessita formalização prática de runbooks.' WHERE id = 'ctrl-a526';
UPDATE compliance_controls SET status = 'Implemented', maturity = 3, owner = 'DevOps', description = 'Segregação de redes via VPC e Security Groups (SOP-004).' WHERE id = 'ctrl-a822';

-- 5. Inserir Inventário de Ativos Real da TWYN (Sprint E)
INSERT INTO assets (id, project_id, name, category, classification, owner, location, status) VALUES
('asset-twyn-01', 'mr9c1qugo16zic2eko', 'Biometric Data (Face Embeddings)', 'Informação', 'Confidential', 'DevOps Lead', 'AWS S3: twyn-biometric-data (AES-256)', 'Active'),
('asset-twyn-02', 'mr9c1qugo16zic2eko', 'AWS RDS Database', 'Software', 'Confidential', 'DB Admin', 'AWS RDS Subnet', 'Active'),
('asset-twyn-03', 'mr9c1qugo16zic2eko', 'EKS Cluster (twyn-faceid-prod)', 'Software', 'Restricted', 'DevOps Lead', 'AWS EKS us-east-1', 'Active'),
('asset-twyn-04', 'mr9c1qugo16zic2eko', 'AWS IAM Credentials', 'Informação', 'Confidential', 'DevOps Lead', 'Secrets Manager e .env files (legacy - RISCO)', 'Active'),
('asset-twyn-05', 'mr9c1qugo16zic2eko', 'AWS Config', 'Software', 'Internal', 'DevOps Lead', 'AWS Account compliance engine', 'Active')
ON CONFLICT(id) DO NOTHING;

-- 6. Evidências
INSERT INTO evidence (id, control_id, project_id, file_name, r2_key, file_hash, file_type, uploaded_by, created_at) VALUES
('ev-twyn-scope',  'ctrl-a51', 'mr9c1qugo16zic2eko', 'SGSI-SCOPE-001 - ISMS Scope.md', 'twyn/scope.md', 'sha256-b8a9c8d7e6f5...', 'text/markdown', 'consultant@ness.io', '2026-05-26 10:00:00'),
('ev-twyn-policy', 'ctrl-a51', 'mr9c1qugo16zic2eko', 'SGSI-POLICY-001 - Information Security Policy.md', 'twyn/policy.md', 'sha256-a1b2c3d4e5f6...', 'text/markdown', 'consultant@ness.io', '2026-05-26 11:30:00')
ON CONFLICT(id) DO NOTHING;

-- 7. Riscos da TWYN vinculados a Ativos e Controles Annex A (Sprint E)
INSERT INTO risks (id, project_id, asset_id, control_id, asset, threat, vulnerability, impact, probability, risk_level, treatment, status) VALUES
('risk-twyn-01', 'mr9c1qugo16zic2eko', 'asset-twyn-01', 'ctrl-a515', 'Face ID API', 'Acesso não autorizado', 'MFA não obrigatório em todos os endpoints', 5, 2, 'High', 'Mitigate', 'Open'),
('risk-twyn-02', 'mr9c1qugo16zic2eko', 'asset-twyn-02', 'ctrl-a824', 'AWS RDS', 'Vazamento de Dados Biométricos', 'Criptografia em repouso não validada', 5, 1, 'Medium', 'Mitigate', 'Open'),
('risk-twyn-03', 'mr9c1qugo16zic2eko', 'asset-twyn-01', 'ctrl-a812', 'Bucket R2', 'Exposição acidental de logs', 'Políticas de bucket permissivas', 4, 3, 'High', 'Mitigate', 'Open'),
('risk-twyn-04', 'mr9c1qugo16zic2eko', 'asset-twyn-04', 'ctrl-a517', 'AWS IAM Credentials', 'Vazamento de Chaves Privadas', 'Uso de .env files legados', 5, 4, 'Critical', 'Mitigate', 'Open'),
('risk-twyn-05', 'mr9c1qugo16zic2eko', 'asset-twyn-05', 'ctrl-a89',  'AWS Config', 'Não Conformidade com AWS FTR', 'AWS Config não plenamente operacional', 3, 4, 'Medium', 'Mitigate', 'Open'),
('risk-twyn-06', 'mr9c1qugo16zic2eko', 'asset-twyn-01', 'ctrl-a824', 'S3 Biometric Buckets', 'Biometric data breach (S3 misconfig)', 'Public access possible, lack of encryption', 5, 5, 'Critical', 'Mitigate', 'Open'),
('risk-twyn-07', 'mr9c1qugo16zic2eko', 'asset-twyn-04', 'ctrl-a515', 'AWS Root Account', 'Unauthorized root access', 'Root used for daily ops, key stored insecurely', 5, 4, 'Critical', 'Mitigate', 'Open'),
('risk-twyn-08', 'mr9c1qugo16zic2eko', 'asset-twyn-03', 'ctrl-a816', 'EKS Clusters', 'Ransomware attack', 'Cluster monitoring gaps, unpatched nodes', 5, 4, 'Critical', 'Mitigate', 'Open'),
('risk-twyn-09', 'mr9c1qugo16zic2eko', 'asset-twyn-04', 'ctrl-a518', 'IAM Policies', 'IAM Over-permissioning (Insider)', 'Many users with AdministratorAccess', 4, 4, 'High', 'Mitigate', 'Open'),
('risk-twyn-10', 'mr9c1qugo16zic2eko', 'asset-twyn-05', 'ctrl-a57',  'AWS Account', 'Lack of Threat Detection', 'No GuardDuty active', 5, 3, 'High', 'Mitigate', 'Open')
ON CONFLICT(id) DO NOTHING;

-- 8. Fornecedores
INSERT INTO vendors (id, project_id, name, category, trust_score, status) VALUES
('vendor-aws',    'mr9c1qugo16zic2eko', 'Amazon Web Services (AWS)', 'Cloud Infrastructure', 95, 'Approved'),
('vendor-github', 'mr9c1qugo16zic2eko', 'GitHub', 'Source Code Management', 92, 'Approved'),
('vendor-linear', 'mr9c1qugo16zic2eko', 'Linear', 'Project Management', 88, 'Approved')
ON CONFLICT(id) DO NOTHING;

-- 9. Treinamento
INSERT INTO training_records (id, project_id, employee_name, training_name, completion_date, status, score) VALUES
('train-01', 'mr9c1qugo16zic2eko', 'Kacio Lopes', 'Governança SGSI para Liderança', '2026-06-20', 'Completed', 100),
('train-02', 'mr9c1qugo16zic2eko', 'Rosa Correia', 'Operações e Compliance ISO 27001', '2026-06-21', 'Completed', 95),
('train-03', 'mr9c1qugo16zic2eko', 'Humberto Oliveira', 'Privacidade e Proteção de Dados Biométricos', '2026-06-22', 'Completed', 98)
ON CONFLICT(id) DO NOTHING;

-- 10. Calendário de Auditoria
INSERT INTO audit_schedule (id, project_id, audit_type, title, scheduled_date, auditor_name, status) VALUES
('audit-01', 'mr9c1qugo16zic2eko', 'Internal', 'Auditoria Interna Ciclo 1', '2026-08-15', 'Consultor ness. Sênior', 'Planned'),
('audit-02', 'mr9c1qugo16zic2eko', 'External', 'Auditoria de Certificação (Stage 1)', '2026-09-20', 'Organismo Certificador (TUV/BSI)', 'Planned')
ON CONFLICT(id) DO NOTHING;

-- 11. Ações Corretivas (CAPA)
INSERT INTO corrective_actions (id, project_id, title, description, root_cause, action_plan, status, severity, control_id) VALUES
('capa-01', 'mr9c1qugo16zic2eko', 'Rotação de Credenciais Críticas', 'Chave tmpsaasboost no Secrets Manager não rotacionada há mais de 90 dias.', 'Processo manual sem automação', 'Implementar Lambda para rotação automática e atualizar SOP-004.', 'Open', 'Critical', 'ctrl-a517'),
('capa-02', 'mr9c1qugo16zic2eko', 'Execução de Teste de Disaster Recovery', 'Testes de restore de backup RDS nunca realizados.', 'Priorização em features', 'Agendar e executar teste de restore do RDS em staging.', 'Open', 'High', 'ctrl-a530'),
('capa-03', 'mr9c1qugo16zic2eko', 'Contradição de Continuidade', 'Política prevê restore semanal, mas Risk Register informa testes nunca executados.', 'Falha operacional vs política escrita', 'Realizar teste de DR imediato.', 'Open', 'High', 'ctrl-a530')
ON CONFLICT(id) DO NOTHING;

-- 12. Stakeholders Reais da TWYN (Sprint E)
INSERT INTO stakeholders (id, project_id, name, type, category, requirements, influence, communication_method) VALUES
('stake-twyn-01', 'mr9c1qugo16zic2eko', 'ANPD (Autoridade Nacional)', 'external', 'regulator', 'Conformidade integral com a LGPD, proteção rigorosa de dados faciais sensíveis e apresentação de DPIA quando solicitado.', 'High', 'Oficial / Notificações e Relatórios'),
('stake-twyn-02', 'mr9c1qugo16zic2eko', 'Bekaa Trusted Advisors (Board)', 'external', 'client', 'Transparência em riscos, SLAs de segurança rígidos para API e conformidade com ISO 27001:2022.', 'High', 'Reuniões de Board / E-mail'),
('stake-twyn-03', 'mr9c1qugo16zic2eko', 'Time de Engenharia & DevOps', 'internal', 'employee', 'Processo simplificado de chaves, automação de infraestrutura segura e SDLC automatizado.', 'Medium', 'Slack / Daily / Linear'),
('stake-twyn-04', 'mr9c1qugo16zic2eko', 'Usuários Finais da Face ID API', 'external', 'client', 'Garantia de confidencialidade dos templates biométricos e não compartilhamento com terceiros.', 'Low', 'Portal Público / Canal LGPD')
ON CONFLICT(id) DO NOTHING;

-- 13. Análise de Contexto SWOT Real da TWYN (Sprint E)
INSERT INTO context_analysis (id, project_id, internal_strengths, internal_weaknesses, external_opportunities, external_threats, legal_requirements, contractual_requirements) VALUES
('ctx-twyn-01', 'mr9c1qugo16zic2eko',
 'Criptografia forte (AES-256) em buckets S3, arquitetura isolada via VPC e Kubernetes (EKS) e segregação lógica de ambientes.',
 'Credenciais temporárias e manuais no Secrets Manager, testes de restore de backup RDS nunca executados formalmente e ausência de GuardDuty.',
 'Liderança competitiva no mercado ao demonstrar certificação ISO 27001:2022 de biometria facial.',
 'Ataques ransomwares direcionados, vazamento acidental de chaves de acesso na AWS e autuações severas da ANPD.',
 'Lei Geral de Proteção de Dados (LGPD - Lei 13.709/2018), resoluções da ANPD sobre tratamento de dados biométricos sensíveis.',
 '')
ON CONFLICT(id) DO UPDATE SET
  internal_strengths = excluded.internal_strengths,
  internal_weaknesses = excluded.internal_weaknesses,
  external_opportunities = excluded.external_opportunities,
  external_threats = excluded.external_threats,
  legal_requirements = excluded.legal_requirements,
  contractual_requirements = excluded.contractual_requirements;

-- 14. Notas do Auditor Externo (Sprint E)
INSERT INTO auditor_notes (id, project_id, auditor_token, control_id, note_type, content, response, responded_by, responded_at) VALUES
('note-twyn-01', 'mr9c1qugo16zic2eko', 'token-auditor-fake', 'ctrl-a517', 'evidence_request', 'Poderia fornecer as evidências de rotação da chave tmpsaasboost no Secrets Manager?', 'Não há evidências de rotação nos últimos 90 dias. A CAPA-01 foi aberta para automatizar esse processo via AWS Lambda.', 'admin', '2026-07-07 10:00:00'),
('note-twyn-02', 'mr9c1qugo16zic2eko', 'token-auditor-fake', 'ctrl-a530', 'question', 'Existe algum relatório formal de testes de restore de backup do RDS?', 'Ainda não executamos o restore formal em staging, apenas validações de integridade automática no S3. O teste formal está planejado no âmbito da CAPA-02.', 'admin', '2026-07-07 11:30:00')
ON CONFLICT(id) DO NOTHING;

-- 15. Audit Logs
INSERT INTO audit_logs (id, action, actor, details, created_at) VALUES
('alog-01', 'Review', 'admin', 'Revisão do Escopo do SGSI: Aprovado sem ressalvas.', '2026-06-10 14:00:00'),
('alog-02', 'Review', 'admin', 'Política de SI: Necessita assinatura do CEO.', '2026-06-10 15:30:00'),
('alog-03', 'Approval', 'admin', 'Controle A.5.1 validado com base na política SGSI-POLICY-001.', '2026-07-06 10:00:00')
ON CONFLICT(id) DO NOTHING;

-- 16. Chat History (simulação)
INSERT INTO ai_chat_history (id, project_id, user_id, role, content, created_at) VALUES
('chat-01', 'mr9c1qugo16zic2eko', 'admin', 'user', 'Qual o escopo atual da certificação TWYN?', '2026-05-26 09:00:00'),
('chat-02', 'mr9c1qugo16zic2eko', 'admin', 'assistant', 'O escopo do SGSI da TWYN abrange a Face ID Platform API e toda a infraestrutura AWS associada, conforme definido no documento SGSI-SCOPE-001.', '2026-07-06 09:00:05')
ON CONFLICT(id) DO NOTHING;

-- 17. Checklist Progress (Sprint F - Persistência do progresso do checklist)
INSERT INTO checklist_progress (id, project_id, phase_number, item_id, is_checked, checked_by, checked_at, notes, assigned_to, due_date) VALUES
('chk-mr9c1qugo16zic2eko-p0_1', 'mr9c1qugo16zic2eko', 0, 'p0_1', 1, 'admin', CURRENT_TIMESTAMP, 'Reunião de kick-off realizada em 20/05 com o board executivo. Apresentação do cronograma nISO e das metas.', 'Kacio Lopes', '2026-05-01'),
('chk-mr9c1qugo16zic2eko-p0_2', 'mr9c1qugo16zic2eko', 0, 'p0_2', 1, 'admin', CURRENT_TIMESTAMP, 'Sponsor executivo nomeado formalmente (CEO da TWYN). Matriz de governança inicial estabelecida.', 'Kacio Lopes', '2026-05-02'),
('chk-mr9c1qugo16zic2eko-p0_3', 'mr9c1qugo16zic2eko', 0, 'p0_3', 1, 'admin', CURRENT_TIMESTAMP, 'Carta de mandato do SGSI assinada eletronicamente via Docusign e publicada na intranet da TWYN.', 'Kacio Lopes', '2026-05-03'),
('chk-mr9c1qugo16zic2eko-p0_4', 'mr9c1qugo16zic2eko', 0, 'p0_4', 1, 'admin', CURRENT_TIMESTAMP, 'Recursos orçamentários para adequação e contratação de ferramentas (SAST, backup) aprovados.', 'Enes Degasperi', '2026-05-04'),
('chk-mr9c1qugo16zic2eko-p0_5', 'mr9c1qugo16zic2eko', 0, 'p0_5', 1, 'admin', CURRENT_TIMESTAMP, 'Equipe do projeto definida: CISO (Humberto), IT Manager (Kacio) e Rosa como consultora principal.', 'Ricardo Esper', '2026-05-05'),
('chk-mr9c1qugo16zic2eko-p0_6', 'mr9c1qugo16zic2eko', 0, 'p0_6', 1, 'admin', CURRENT_TIMESTAMP, 'Definição do comitê de segurança da informação (Hono Board) com reuniões mensais fixadas.', 'Kacio Lopes', '2026-05-06'),
('chk-mr9c1qugo16zic2eko-p0_7', 'mr9c1qugo16zic2eko', 0, 'p0_7', 1, 'admin', CURRENT_TIMESTAMP, 'Termo de abertura do projeto assinado e salvo na pasta raiz GRC.', 'Ricardo Esper', '2026-05-07'),
('chk-mr9c1qugo16zic2eko-p1_1', 'mr9c1qugo16zic2eko', 1, 'p1_1', 1, 'admin', CURRENT_TIMESTAMP, 'Conduzida entrevista estratégica com o C-Level para alinhamento estratégico de TI.', 'Ricardo Esper', '2026-05-10'),
('chk-mr9c1qugo16zic2eko-p1_2', 'mr9c1qugo16zic2eko', 1, 'p1_2', 1, 'admin', CURRENT_TIMESTAMP, 'Nível de apetite de risco da empresa definido como Moderado para riscos de infraestrutura.', 'Kacio Lopes', '2026-05-11'),
('chk-mr9c1qugo16zic2eko-p1_3', 'mr9c1qugo16zic2eko', 1, 'p1_3', 1, 'admin', CURRENT_TIMESTAMP, 'Identificadas as principais dores de conformidade da diretoria (bloqueio de novos contratos sem ISO).', 'Kacio Lopes', '2026-05-12'),
('chk-mr9c1qugo16zic2eko-p1_4', 'mr9c1qugo16zic2eko', 1, 'p1_4', 1, 'admin', CURRENT_TIMESTAMP, 'Lista de prioridades executivas homologada pela diretoria da TWYN.', 'Kacio Lopes', '2026-05-13'),
('chk-mr9c1qugo16zic2eko-p2_1', 'mr9c1qugo16zic2eko', 2, 'p2_1', 1, 'admin', CURRENT_TIMESTAMP, 'Entrevistas da trilha de TI concluídas com Kacio Lopes. Mapeadas ferramentas AWS.', 'Ricardo Esper', '2026-05-16'),
('chk-mr9c1qugo16zic2eko-p2_2', 'mr9c1qugo16zic2eko', 2, 'p2_2', 1, 'admin', CURRENT_TIMESTAMP, 'Entrevistas da trilha de Recursos Humanos finalizadas para mapear admissões/demissões.', 'Ricardo Esper', '2026-05-17'),
('chk-mr9c1qugo16zic2eko-p2_3', 'mr9c1qugo16zic2eko', 2, 'p2_3', 1, 'admin', CURRENT_TIMESTAMP, 'Entrevistas com a equipe de desenvolvimento (DevOps) sobre esteira de CI/CD e segurança.', 'Ricardo Esper', '2026-05-18'),
('chk-mr9c1qugo16zic2eko-p2_4', 'mr9c1qugo16zic2eko', 2, 'p2_4', 1, 'admin', CURRENT_TIMESTAMP, 'Entrevistas com o setor financeiro e compras para mapear os fluxos de fornecedores.', 'Enes Degasperi', '2026-05-19'),
('chk-mr9c1qugo16zic2eko-p3_1', 'mr9c1qugo16zic2eko', 3, 'p3_1', 1, 'admin', CURRENT_TIMESTAMP, 'Definido o escopo preliminar abrangendo a plataforma Face ID e banco de dados.', 'Augusto Ferronato', '2026-05-22'),
('chk-mr9c1qugo16zic2eko-p3_2', 'mr9c1qugo16zic2eko', 3, 'p3_2', 1, 'admin', CURRENT_TIMESTAMP, 'Documento oficial de escopo SGSI/SGPI (SGSI-SCOPE-001) redigido e armazenado.', 'Ricardo Esper', '2026-05-23'),
('chk-mr9c1qugo16zic2eko-p3_3', 'mr9c1qugo16zic2eko', 3, 'p3_3', 1, 'admin', CURRENT_TIMESTAMP, 'Assinatura e aprovação do documento de escopo obtida junto ao CISO da TWYN.', 'Ricardo Esper', '2026-05-24'),
('chk-mr9c1qugo16zic2eko-p3_4', 'mr9c1qugo16zic2eko', 3, 'p3_4', 1, 'admin', CURRENT_TIMESTAMP, 'Mapeadas as fronteiras físicas e lógicas da API hospedada na AWS (Região us-east-1).', 'Augusto Ferronato', '2026-05-25'),
('chk-mr9c1qugo16zic2eko-p3_5', 'mr9c1qugo16zic2eko', 3, 'p3_5', 1, 'admin', CURRENT_TIMESTAMP, 'Exclusões justificadas para o escopo (escritório físico de vendas fora da matriz do SGSI).', 'Rosa Correia', '2026-05-26'),
('chk-mr9c1qugo16zic2eko-p3_6', 'mr9c1qugo16zic2eko', 3, 'p3_6', 1, 'admin', CURRENT_TIMESTAMP, 'Publicada versão controlada 1.0 do escopo aprovada no comitê de segurança.', 'Kacio Lopes', '2026-05-27'),
('chk-mr9c1qugo16zic2eko-p4_1', 'mr9c1qugo16zic2eko', 4, 'p4_1', 1, 'admin', CURRENT_TIMESTAMP, 'Questionário do Gap Assessment inicial respondido pela equipe técnica.', 'Ricardo Esper', '2026-05-02'),
('chk-mr9c1qugo16zic2eko-p4_2', 'mr9c1qugo16zic2eko', 4, 'p4_2', 1, 'admin', CURRENT_TIMESTAMP, 'Reuniões de validação dos gaps realizadas em cada controle do Anexo A.', 'Ricardo Esper', '2026-05-03'),
('chk-mr9c1qugo16zic2eko-p4_3', 'mr9c1qugo16zic2eko', 4, 'p4_3', 1, 'admin', CURRENT_TIMESTAMP, 'Identificadas vulnerabilidades em produção (falta de criptografia em alguns logs de depuração).', 'Ricardo Esper', '2026-05-04'),
('chk-mr9c1qugo16zic2eko-p4_4', 'mr9c1qugo16zic2eko', 4, 'p4_4', 1, 'admin', CURRENT_TIMESTAMP, 'Desenvolvido o plano de mitigação rápida (Quick Wins) para criptografia e MFA.', 'Ricardo Esper', '2026-05-05'),
('chk-mr9c1qugo16zic2eko-p4_5', 'mr9c1qugo16zic2eko', 4, 'p4_5', 1, 'admin', CURRENT_TIMESTAMP, 'MFA ativado obrigatoriamente para todas as contas AWS e consoles corporativos.', 'Ricardo Esper', '2026-05-06'),
('chk-mr9c1qugo16zic2eko-p4_6', 'mr9c1qugo16zic2eko', 4, 'p4_6', 1, 'admin', CURRENT_TIMESTAMP, 'Apresentado relatório geral de gap à diretoria com 42% de conformidade inicial.', 'Kacio Lopes', '2026-05-07'),
('chk-mr9c1qugo16zic2eko-p4_7', 'mr9c1qugo16zic2eko', 4, 'p4_7', 1, 'admin', CURRENT_TIMESTAMP, 'Identificadas as não-conformidades críticas e integradas no roadmap geral.', 'Ricardo Esper', '2026-05-08'),
('chk-mr9c1qugo16zic2eko-p5_1', 'mr9c1qugo16zic2eko', 5, 'p5_1', 1, 'admin', CURRENT_TIMESTAMP, 'Matriz de governança de segurança elaborada. Humberto Oliveira assume como DPO e CISO.', 'Rosa Correia', '2026-05-11'),
('chk-mr9c1qugo16zic2eko-p5_2', 'mr9c1qugo16zic2eko', 5, 'p5_2', 1, 'admin', CURRENT_TIMESTAMP, 'Matriz RACI para o SGSI construída e distribuída para todos os gerentes de área.', 'Rosa Correia', '2026-05-12'),
('chk-mr9c1qugo16zic2eko-p5_3', 'mr9c1qugo16zic2eko', 5, 'p5_3', 1, 'admin', CURRENT_TIMESTAMP, 'Políticas de contratação de terceiros atualizadas com obrigatoriedade de background checks.', 'Ricardo Esper', '2026-05-13'),
('chk-mr9c1qugo16zic2eko-p5_4', 'mr9c1qugo16zic2eko', 5, 'p5_4', 1, 'admin', CURRENT_TIMESTAMP, 'Termos de nomeação do comitê de segurança assinados pelos diretores participantes.', 'Kacio Lopes', '2026-05-14'),
('chk-mr9c1qugo16zic2eko-p6_1', 'mr9c1qugo16zic2eko', 6, 'p6_1', 1, 'admin', CURRENT_TIMESTAMP, 'Análise de contexto organizacional SWOT concluída. Identificadas ameaças de concorrência.', 'Ricardo Esper', '2026-05-17'),
('chk-mr9c1qugo16zic2eko-p6_2', 'mr9c1qugo16zic2eko', 6, 'p6_2', 1, 'admin', CURRENT_TIMESTAMP, 'Partes interessadas (clientes, ANPD, investidores) e suas necessidades legais catalogadas.', 'Ricardo Esper', '2026-05-18'),
('chk-mr9c1qugo16zic2eko-p6_3', 'mr9c1qugo16zic2eko', 6, 'p6_3', 1, 'admin', CURRENT_TIMESTAMP, 'Requisitos contratuais de segurança de grandes clientes agregados na matriz de conformidade.', 'Ricardo Esper', '2026-05-19'),
('chk-mr9c1qugo16zic2eko-p6_4', 'mr9c1qugo16zic2eko', 6, 'p6_4', 1, 'admin', CURRENT_TIMESTAMP, 'SWOT corporativo homologado pela direção da TWYN.', 'Ricardo Esper', '2026-05-20'),
('chk-mr9c1qugo16zic2eko-p7_1', 'mr9c1qugo16zic2eko', 7, 'p7_1', 1, 'admin', CURRENT_TIMESTAMP, 'Inventário de ativos concluído. Cadastrados 14 servidores EC2, RDS e S3 Buckets.', 'Ricardo Esper', '2026-06-23'),
('chk-mr9c1qugo16zic2eko-p7_2', 'mr9c1qugo16zic2eko', 7, 'p7_2', 1, 'admin', CURRENT_TIMESTAMP, 'Ativos críticos (dados biométricos) classificados sob a política como Confidenciais.', 'Ricardo Esper', '2026-06-24'),
('chk-mr9c1qugo16zic2eko-p7_3', 'mr9c1qugo16zic2eko', 7, 'p7_3', 1, 'admin', CURRENT_TIMESTAMP, 'Proprietários (owners) de ativos atribuídos no sistema: Kacio responsável pela infra AWS.', 'Nizar Elouaer', '2026-06-25'),
('chk-mr9c1qugo16zic2eko-p7_4', 'mr9c1qugo16zic2eko', 7, 'p7_4', 1, 'admin', CURRENT_TIMESTAMP, 'Inventário de dados pessoais (RoPA) mapeado na planilha de privacidade de dados.', 'Ricardo Esper', '2026-06-26'),
('chk-mr9c1qugo16zic2eko-p7_5', 'mr9c1qugo16zic2eko', 7, 'p7_5', 1, 'admin', CURRENT_TIMESTAMP, 'Classificação de dados sensíveis concluída na ferramenta de descoberta de dados da AWS.', 'Nizar Elouaer', '2026-06-27'),
('chk-mr9c1qugo16zic2eko-p8_1', 'mr9c1qugo16zic2eko', 8, 'p8_1', 1, 'admin', CURRENT_TIMESTAMP, 'Mapeamento de processos críticos de negócio (Validação Facial, Cadastro) finalizado.', 'Ricardo Esper', '2026-06-02'),
('chk-mr9c1qugo16zic2eko-p8_2', 'mr9c1qugo16zic2eko', 8, 'p8_2', 1, 'admin', CURRENT_TIMESTAMP, 'Identificados os fluxos de dados sensíveis na integração com os clientes via API.', 'Ricardo Esper', '2026-06-03'),
('chk-mr9c1qugo16zic2eko-p8_3', 'mr9c1qugo16zic2eko', 8, 'p8_3', 1, 'admin', CURRENT_TIMESTAMP, 'Documentada a arquitetura de rede e tráfego de dados de ponta a ponta.', 'Ricardo Esper', '2026-06-04'),
('chk-mr9c1qugo16zic2eko-p8_4', 'mr9c1qugo16zic2eko', 8, 'p8_4', 1, 'admin', CURRENT_TIMESTAMP, 'Processos homologados pelos respectivos gerentes operacionais.', 'Ricardo Esper', '2026-06-05'),
('chk-mr9c1qugo16zic2eko-p9_1', 'mr9c1qugo16zic2eko', 9, 'p9_1', 1, 'admin', CURRENT_TIMESTAMP, 'Identificação preliminar de ameaças às APIs da TWYN (DDoS, vazamento de credenciais).', 'Augusto Ferronato', '2026-06-08'),
('chk-mr9c1qugo16zic2eko-p9_2', 'mr9c1qugo16zic2eko', 9, 'p9_2', 1, 'admin', CURRENT_TIMESTAMP, 'Vulnerabilidades de injeção de dependências identificadas na esteira de build.', 'Augusto Ferronato', '2026-06-09'),
('chk-mr9c1qugo16zic2eko-p9_3', 'mr9c1qugo16zic2eko', 9, 'p9_3', 1, 'admin', CURRENT_TIMESTAMP, 'Conduzida análise qualitativa de impacto para os principais cenários de ameaça.', 'Ricardo Esper', '2026-06-10'),
('chk-mr9c1qugo16zic2eko-p9_4', 'mr9c1qugo16zic2eko', 9, 'p9_4', 1, 'admin', CURRENT_TIMESTAMP, 'Matriz de riscos consolidada com 12 riscos identificados no painel operacional.', 'Ricardo Esper', '2026-06-11'),
('chk-mr9c1qugo16zic2eko-p9_5', 'mr9c1qugo16zic2eko', 9, 'p9_5', 1, 'admin', CURRENT_TIMESTAMP, 'Avaliados os riscos de fornecedores de cloud com pontuação máxima tolerável.', 'Rosa Correia', '2026-06-12'),
('chk-mr9c1qugo16zic2eko-p9_6', 'mr9c1qugo16zic2eko', 9, 'p9_6', 1, 'admin', CURRENT_TIMESTAMP, 'Relatório preliminar de riscos aprovado pelo CISO da TWYN.', 'Ricardo Esper', '2026-06-13'),
('chk-mr9c1qugo16zic2eko-p9_7', 'mr9c1qugo16zic2eko', 9, 'p9_7', 1, 'admin', CURRENT_TIMESTAMP, 'Vulnerabilidades adicionais em bibliotecas open-source catalogadas para correção.', 'Augusto Ferronato', '2026-06-14'),
('chk-mr9c1qugo16zic2eko-p9_8', 'mr9c1qugo16zic2eko', 9, 'p9_8', 1, 'admin', CURRENT_TIMESTAMP, 'Identificados riscos associados à interrupção de infraestrutura por falha da AWS.', 'Nizar Elouaer', '2026-06-15'),
('chk-mr9c1qugo16zic2eko-p10_1', 'mr9c1qugo16zic2eko', 10, 'p10_1', 1, 'admin', CURRENT_TIMESTAMP, 'Mapeados os riscos de privacidade no processamento de imagens faciais.', 'Ricardo Esper', '2026-06-18'),
('chk-mr9c1qugo16zic2eko-p10_2', 'mr9c1qugo16zic2eko', 10, 'p10_2', 1, 'admin', CURRENT_TIMESTAMP, 'DPIA/RIPD elaborado para o processo de validação de biometria facial.', 'Ricardo Esper', '2026-06-19'),
('chk-mr9c1qugo16zic2eko-p10_3', 'mr9c1qugo16zic2eko', 10, 'p10_3', 1, 'admin', CURRENT_TIMESTAMP, 'Medidas mitigadoras (salting de hashes biométricos) aprovadas pela equipe de criptografia.', 'Ricardo Esper', '2026-06-20'),
('chk-mr9c1qugo16zic2eko-p10_4', 'mr9c1qugo16zic2eko', 10, 'p10_4', 1, 'admin', CURRENT_TIMESTAMP, 'DPIA/RIPD publicado e disponibilizado para consulta do comitê interno de privacidade.', 'Kacio Lopes', '2026-06-21'),
('chk-mr9c1qugo16zic2eko-p11_1', 'mr9c1qugo16zic2eko', 11, 'p11_1', 1, 'admin', CURRENT_TIMESTAMP, 'Metodologia e opções de tratamento de riscos definidas para cada item avaliado.', 'Ricardo Esper', '2026-06-24'),
('chk-mr9c1qugo16zic2eko-p11_2', 'mr9c1qugo16zic2eko', 11, 'p11_2', 1, 'admin', CURRENT_TIMESTAMP, 'Plano de tratamento de riscos (RTP) oficial aprovado no comitê de segurança.', 'Kacio Lopes', '2026-06-25'),
('chk-mr9c1qugo16zic2eko-p11_3', 'mr9c1qugo16zic2eko', 11, 'p11_3', 1, 'admin', CURRENT_TIMESTAMP, 'Termo de aceitação de riscos residuais assinado formalmente pela diretoria.', 'Kacio Lopes', '2026-06-26'),
('chk-mr9c1qugo16zic2eko-p11_4', 'mr9c1qugo16zic2eko', 11, 'p11_4', 1, 'admin', CURRENT_TIMESTAMP, 'Responsáveis pelas mitigações definidos na matriz de acompanhamento técnico.', 'Ricardo Esper', '2026-06-27'),
('chk-mr9c1qugo16zic2eko-p12_1', 'mr9c1qugo16zic2eko', 12, 'p12_1', 1, 'admin', CURRENT_TIMESTAMP, 'SoA consolidado elaborado. Todos os 93 controles analisados um a um.', 'Ricardo Esper', '2026-06-02'),
('chk-mr9c1qugo16zic2eko-p12_2', 'mr9c1qugo16zic2eko', 12, 'p12_2', 1, 'admin', CURRENT_TIMESTAMP, 'Justificativas de exclusão adicionadas no sistema (ex: A.8.23 excluído por time 100% remoto).', 'Ricardo Esper', '2026-06-03'),
('chk-mr9c1qugo16zic2eko-p12_3', 'mr9c1qugo16zic2eko', 12, 'p12_3', 1, 'admin', CURRENT_TIMESTAMP, 'Aprovação final do SoA pelo CISO (Humberto Oliveira).', 'Ricardo Esper', '2026-06-04'),
('chk-mr9c1qugo16zic2eko-p12_4', 'mr9c1qugo16zic2eko', 12, 'p12_4', 1, 'admin', CURRENT_TIMESTAMP, 'Aprovação do SoA pelo CEO e diretoria executiva.', 'Kacio Lopes', '2026-06-05'),
('chk-mr9c1qugo16zic2eko-p12_5', 'mr9c1qugo16zic2eko', 12, 'p12_5', 1, 'admin', CURRENT_TIMESTAMP, 'Declaração de Aplicabilidade publicada na pasta compartilhada de conformidade.', 'Ricardo Esper', '2026-06-06'),
('chk-mr9c1qugo16zic2eko-p12_6', 'mr9c1qugo16zic2eko', 12, 'p12_6', 1, 'admin', CURRENT_TIMESTAMP, 'SoA exportado e compartilhado com a equipe interna de desenvolvimento.', 'Ricardo Esper', '2026-06-07'),
('chk-mr9c1qugo16zic2eko-p13_1', 'mr9c1qugo16zic2eko', 13, 'p13_1', 1, 'admin', CURRENT_TIMESTAMP, 'Análise de aplicabilidade para os controles de privacidade (ISO 27701) concluída.', 'Ricardo Esper', '2026-06-10'),
('chk-mr9c1qugo16zic2eko-p13_2', 'mr9c1qugo16zic2eko', 13, 'p13_2', 1, 'admin', CURRENT_TIMESTAMP, 'SoA de privacidade integrado e alinhado aos controles existentes da ISO 27001.', 'Ricardo Esper', '2026-06-11'),
('chk-mr9c1qugo16zic2eko-p13_3', 'mr9c1qugo16zic2eko', 13, 'p13_3', 1, 'admin', CURRENT_TIMESTAMP, 'Aprovação técnica do SoA de Privacidade emitida pelo CISO.', 'Ricardo Esper', '2026-06-12'),
('chk-mr9c1qugo16zic2eko-p13_4', 'mr9c1qugo16zic2eko', 13, 'p13_4', 1, 'admin', CURRENT_TIMESTAMP, 'Assinatura executiva do SoA de Privacidade realizada pela diretoria.', 'Kacio Lopes', '2026-06-13'),
('chk-mr9c1qugo16zic2eko-p14_1', 'mr9c1qugo16zic2eko', 14, 'p14_1', 1, 'admin', CURRENT_TIMESTAMP, 'Arquitetura documental estruturada com a Lista Mestra de Políticas.', 'Ricardo Esper', '2026-06-16'),
('chk-mr9c1qugo16zic2eko-p14_2', 'mr9c1qugo16zic2eko', 14, 'p14_2', 1, 'admin', CURRENT_TIMESTAMP, 'Definida a codificação oficial (ex: POL-SI-001) para controle de documentos.', 'Ricardo Esper', '2026-06-17'),
('chk-mr9c1qugo16zic2eko-p14_3', 'mr9c1qugo16zic2eko', 14, 'p14_3', 1, 'admin', CURRENT_TIMESTAMP, 'Workflow de aprovação e revisão periódica de documentos formalizado.', 'Ricardo Esper', '2026-06-18'),
('chk-mr9c1qugo16zic2eko-p14_4', 'mr9c1qugo16zic2eko', 14, 'p14_4', 1, 'admin', CURRENT_TIMESTAMP, 'Lista mestra publicada na intranet contendo 10 templates de diretrizes do SGSI.', 'Ricardo Esper', '2026-06-19'),
('chk-mr9c1qugo16zic2eko-p14_5', 'mr9c1qugo16zic2eko', 14, 'p14_5', 1, 'admin', CURRENT_TIMESTAMP, 'Termo de controle documental assinado pela gerência de qualidade.', 'Ricardo Esper', '2026-06-20'),
('chk-mr9c1qugo16zic2eko-p14_6', 'mr9c1qugo16zic2eko', 14, 'p14_6', 1, 'admin', CURRENT_TIMESTAMP, 'Procedimento de controle de informação documentada homologado e ativado.', 'Ricardo Esper', '2026-06-21'),
('chk-mr9c1qugo16zic2eko-p14_7', 'mr9c1qugo16zic2eko', 14, 'p14_7', 1, 'admin', CURRENT_TIMESTAMP, 'Modelos de documentos unificados disponibilizados na nuvem para edição.', 'Nizar Elouaer', '2026-06-22'),
('chk-mr9c1qugo16zic2eko-p15_1', 'mr9c1qugo16zic2eko', 15, 'p15_1', 0, NULL, NULL, NULL, 'Ricardo Esper', '2026-08-25'),
('chk-mr9c1qugo16zic2eko-p15_2', 'mr9c1qugo16zic2eko', 15, 'p15_2', 0, NULL, NULL, NULL, 'Ricardo Esper', '2026-08-26'),
('chk-mr9c1qugo16zic2eko-p15_3', 'mr9c1qugo16zic2eko', 15, 'p15_3', 0, NULL, NULL, NULL, 'Ricardo Esper', '2026-08-27'),
('chk-mr9c1qugo16zic2eko-p15_4', 'mr9c1qugo16zic2eko', 15, 'p15_4', 0, NULL, NULL, NULL, 'Ricardo Esper', '2026-08-28'),
('chk-mr9c1qugo16zic2eko-p16_1', 'mr9c1qugo16zic2eko', 16, 'p16_1', 0, NULL, NULL, NULL, 'Ricardo Esper', '2026-08-03'),
('chk-mr9c1qugo16zic2eko-p16_2', 'mr9c1qugo16zic2eko', 16, 'p16_2', 0, NULL, NULL, NULL, 'Ricardo Esper', '2026-08-04'),
('chk-mr9c1qugo16zic2eko-p16_3', 'mr9c1qugo16zic2eko', 16, 'p16_3', 0, NULL, NULL, NULL, 'Ricardo Esper', '2026-08-05'),
('chk-mr9c1qugo16zic2eko-p16_4', 'mr9c1qugo16zic2eko', 16, 'p16_4', 0, NULL, NULL, NULL, 'Ricardo Esper', '2026-08-06'),
('chk-mr9c1qugo16zic2eko-p17_1', 'mr9c1qugo16zic2eko', 17, 'p17_1', 0, NULL, NULL, NULL, 'Ricardo Esper', '2026-08-09'),
('chk-mr9c1qugo16zic2eko-p17_2', 'mr9c1qugo16zic2eko', 17, 'p17_2', 0, NULL, NULL, NULL, 'Ricardo Esper', '2026-08-10'),
('chk-mr9c1qugo16zic2eko-p17_3', 'mr9c1qugo16zic2eko', 17, 'p17_3', 0, NULL, NULL, NULL, 'Ricardo Esper', '2026-08-11'),
('chk-mr9c1qugo16zic2eko-p17_4', 'mr9c1qugo16zic2eko', 17, 'p17_4', 0, NULL, NULL, NULL, 'Ricardo Esper', '2026-08-12'),
('chk-mr9c1qugo16zic2eko-p18_1', 'mr9c1qugo16zic2eko', 18, 'p18_1', 0, NULL, NULL, NULL, 'Ricardo Esper', '2026-08-15'),
('chk-mr9c1qugo16zic2eko-p18_2', 'mr9c1qugo16zic2eko', 18, 'p18_2', 0, NULL, NULL, NULL, 'Ricardo Esper', '2026-08-16'),
('chk-mr9c1qugo16zic2eko-p18_3', 'mr9c1qugo16zic2eko', 18, 'p18_3', 0, NULL, NULL, NULL, 'Ricardo Esper', '2026-08-17'),
('chk-mr9c1qugo16zic2eko-p18_4', 'mr9c1qugo16zic2eko', 18, 'p18_4', 0, NULL, NULL, NULL, 'Ricardo Esper', '2026-08-18'),
('chk-mr9c1qugo16zic2eko-p18_5', 'mr9c1qugo16zic2eko', 18, 'p18_5', 0, NULL, NULL, NULL, 'Ricardo Esper', '2026-08-19'),
('chk-mr9c1qugo16zic2eko-p19_1', 'mr9c1qugo16zic2eko', 19, 'p19_1', 0, NULL, NULL, NULL, 'Augusto Ferronato', '2026-08-22'),
('chk-mr9c1qugo16zic2eko-p19_2', 'mr9c1qugo16zic2eko', 19, 'p19_2', 0, NULL, NULL, NULL, 'Augusto Ferronato', '2026-08-23'),
('chk-mr9c1qugo16zic2eko-p19_3', 'mr9c1qugo16zic2eko', 19, 'p19_3', 0, NULL, NULL, NULL, 'Augusto Ferronato', '2026-08-24'),
('chk-mr9c1qugo16zic2eko-p19_4', 'mr9c1qugo16zic2eko', 19, 'p19_4', 0, NULL, NULL, NULL, 'Augusto Ferronato', '2026-08-25'),
('chk-mr9c1qugo16zic2eko-p20_1', 'mr9c1qugo16zic2eko', 20, 'p20_1', 0, NULL, NULL, NULL, 'Nizar Elouaer', '2026-08-28'),
('chk-mr9c1qugo16zic2eko-p20_2', 'mr9c1qugo16zic2eko', 20, 'p20_2', 0, NULL, NULL, NULL, 'Nizar Elouaer', '2026-08-01'),
('chk-mr9c1qugo16zic2eko-p20_3', 'mr9c1qugo16zic2eko', 20, 'p20_3', 0, NULL, NULL, NULL, 'Nizar Elouaer', '2026-08-02'),
('chk-mr9c1qugo16zic2eko-p20_4', 'mr9c1qugo16zic2eko', 20, 'p20_4', 0, NULL, NULL, NULL, 'Nizar Elouaer', '2026-08-03'),
('chk-mr9c1qugo16zic2eko-p21_1', 'mr9c1qugo16zic2eko', 21, 'p21_1', 0, NULL, NULL, NULL, 'Ricardo Esper', '2026-08-06'),
('chk-mr9c1qugo16zic2eko-p21_2', 'mr9c1qugo16zic2eko', 21, 'p21_2', 0, NULL, NULL, NULL, 'Ricardo Esper', '2026-08-07'),
('chk-mr9c1qugo16zic2eko-p21_3', 'mr9c1qugo16zic2eko', 21, 'p21_3', 0, NULL, NULL, NULL, 'Ricardo Esper', '2026-08-08'),
('chk-mr9c1qugo16zic2eko-p21_4', 'mr9c1qugo16zic2eko', 21, 'p21_4', 0, NULL, NULL, NULL, 'Ricardo Esper', '2026-08-09'),
('chk-mr9c1qugo16zic2eko-p22_1', 'mr9c1qugo16zic2eko', 22, 'p22_1', 0, NULL, NULL, NULL, 'Humberto Oliveira', '2026-08-12'),
('chk-mr9c1qugo16zic2eko-p22_2', 'mr9c1qugo16zic2eko', 22, 'p22_2', 0, NULL, NULL, NULL, 'Humberto Oliveira', '2026-08-13'),
('chk-mr9c1qugo16zic2eko-p22_3', 'mr9c1qugo16zic2eko', 22, 'p22_3', 0, NULL, NULL, NULL, 'Humberto Oliveira', '2026-08-14'),
('chk-mr9c1qugo16zic2eko-p22_4', 'mr9c1qugo16zic2eko', 22, 'p22_4', 0, NULL, NULL, NULL, 'Humberto Oliveira', '2026-08-15'),
('chk-mr9c1qugo16zic2eko-p23_1', 'mr9c1qugo16zic2eko', 23, 'p23_1', 0, NULL, NULL, NULL, 'Bianca Lopes', '2026-08-18'),
('chk-mr9c1qugo16zic2eko-p23_2', 'mr9c1qugo16zic2eko', 23, 'p23_2', 0, NULL, NULL, NULL, 'Bianca Lopes', '2026-08-19'),
('chk-mr9c1qugo16zic2eko-p23_3', 'mr9c1qugo16zic2eko', 23, 'p23_3', 0, NULL, NULL, NULL, 'Bianca Lopes', '2026-08-20'),
('chk-mr9c1qugo16zic2eko-p23_4', 'mr9c1qugo16zic2eko', 23, 'p23_4', 0, NULL, NULL, NULL, 'Bianca Lopes', '2026-08-21'),
('chk-mr9c1qugo16zic2eko-p24_1', 'mr9c1qugo16zic2eko', 24, 'p24_1', 0, NULL, NULL, NULL, 'Bianca Lopes', '2026-08-24'),
('chk-mr9c1qugo16zic2eko-p24_2', 'mr9c1qugo16zic2eko', 24, 'p24_2', 0, NULL, NULL, NULL, 'Bianca Lopes', '2026-08-25'),
('chk-mr9c1qugo16zic2eko-p24_3', 'mr9c1qugo16zic2eko', 24, 'p24_3', 0, NULL, NULL, NULL, 'Bianca Lopes', '2026-08-26'),
('chk-mr9c1qugo16zic2eko-p24_4', 'mr9c1qugo16zic2eko', 24, 'p24_4', 0, NULL, NULL, NULL, 'Bianca Lopes', '2026-08-27'),
('chk-mr9c1qugo16zic2eko-p25_1', 'mr9c1qugo16zic2eko', 25, 'p25_1', 0, NULL, NULL, NULL, 'Ricardo Esper', '2026-08-02'),
('chk-mr9c1qugo16zic2eko-p25_2', 'mr9c1qugo16zic2eko', 25, 'p25_2', 0, NULL, NULL, NULL, 'Ricardo Esper', '2026-08-03'),
('chk-mr9c1qugo16zic2eko-p25_3', 'mr9c1qugo16zic2eko', 25, 'p25_3', 0, NULL, NULL, NULL, 'Ricardo Esper', '2026-08-04'),
('chk-mr9c1qugo16zic2eko-p25_4', 'mr9c1qugo16zic2eko', 25, 'p25_4', 0, NULL, NULL, NULL, 'Ricardo Esper', '2026-08-05'),
('chk-mr9c1qugo16zic2eko-p26_1', 'mr9c1qugo16zic2eko', 26, 'p26_1', 0, NULL, NULL, NULL, 'Ricardo Esper', '2026-09-08'),
('chk-mr9c1qugo16zic2eko-p26_2', 'mr9c1qugo16zic2eko', 26, 'p26_2', 0, NULL, NULL, NULL, 'Ricardo Esper', '2026-09-09'),
('chk-mr9c1qugo16zic2eko-p26_3', 'mr9c1qugo16zic2eko', 26, 'p26_3', 0, NULL, NULL, NULL, 'Ricardo Esper', '2026-09-10'),
('chk-mr9c1qugo16zic2eko-p26_4', 'mr9c1qugo16zic2eko', 26, 'p26_4', 0, NULL, NULL, NULL, 'Ricardo Esper', '2026-09-11'),
('chk-mr9c1qugo16zic2eko-p27_1', 'mr9c1qugo16zic2eko', 27, 'p27_1', 0, NULL, NULL, NULL, 'Rosa Correia', '2026-09-14'),
('chk-mr9c1qugo16zic2eko-p27_2', 'mr9c1qugo16zic2eko', 27, 'p27_2', 0, NULL, NULL, NULL, 'Rosa Correia', '2026-09-15'),
('chk-mr9c1qugo16zic2eko-p27_3', 'mr9c1qugo16zic2eko', 27, 'p27_3', 0, NULL, NULL, NULL, 'Rosa Correia', '2026-09-16'),
('chk-mr9c1qugo16zic2eko-p27_4', 'mr9c1qugo16zic2eko', 27, 'p27_4', 0, NULL, NULL, NULL, 'Rosa Correia', '2026-09-17'),
('chk-mr9c1qugo16zic2eko-p28_1', 'mr9c1qugo16zic2eko', 28, 'p28_1', 0, NULL, NULL, NULL, 'Rosa Correia', '2026-09-20'),
('chk-mr9c1qugo16zic2eko-p28_2', 'mr9c1qugo16zic2eko', 28, 'p28_2', 0, NULL, NULL, NULL, 'Rosa Correia', '2026-09-21'),
('chk-mr9c1qugo16zic2eko-p28_3', 'mr9c1qugo16zic2eko', 28, 'p28_3', 0, NULL, NULL, NULL, 'Rosa Correia', '2026-09-22'),
('chk-mr9c1qugo16zic2eko-p28_4', 'mr9c1qugo16zic2eko', 28, 'p28_4', 0, NULL, NULL, NULL, 'Rosa Correia', '2026-09-23'),
('chk-mr9c1qugo16zic2eko-p28_5', 'mr9c1qugo16zic2eko', 28, 'p28_5', 0, NULL, NULL, NULL, 'Rosa Correia', '2026-09-24'),
('chk-mr9c1qugo16zic2eko-p28_6', 'mr9c1qugo16zic2eko', 28, 'p28_6', 0, NULL, NULL, NULL, 'Rosa Correia', '2026-09-25'),
('chk-mr9c1qugo16zic2eko-p28_7', 'mr9c1qugo16zic2eko', 28, 'p28_7', 0, NULL, NULL, NULL, 'Rosa Correia', '2026-09-26'),
('chk-mr9c1qugo16zic2eko-p28_8', 'mr9c1qugo16zic2eko', 28, 'p28_8', 0, NULL, NULL, NULL, 'Rosa Correia', '2026-09-27'),
('chk-mr9c1qugo16zic2eko-p29_1', 'mr9c1qugo16zic2eko', 29, 'p29_1', 0, NULL, NULL, NULL, 'Rosa Correia', '2026-09-02'),
('chk-mr9c1qugo16zic2eko-p29_2', 'mr9c1qugo16zic2eko', 29, 'p29_2', 0, NULL, NULL, NULL, 'Rosa Correia', '2026-09-03'),
('chk-mr9c1qugo16zic2eko-p29_3', 'mr9c1qugo16zic2eko', 29, 'p29_3', 0, NULL, NULL, NULL, 'Rosa Correia', '2026-09-04'),
('chk-mr9c1qugo16zic2eko-p29_4', 'mr9c1qugo16zic2eko', 29, 'p29_4', 0, NULL, NULL, NULL, 'Rosa Correia', '2026-09-05'),
('chk-mr9c1qugo16zic2eko-p30_1', 'mr9c1qugo16zic2eko', 30, 'p30_1', 0, NULL, NULL, NULL, 'Ricardo Esper', '2026-09-08'),
('chk-mr9c1qugo16zic2eko-p30_2', 'mr9c1qugo16zic2eko', 30, 'p30_2', 0, NULL, NULL, NULL, 'Ricardo Esper', '2026-09-09'),
('chk-mr9c1qugo16zic2eko-p30_3', 'mr9c1qugo16zic2eko', 30, 'p30_3', 0, NULL, NULL, NULL, 'Ricardo Esper', '2026-09-10'),
('chk-mr9c1qugo16zic2eko-p30_4', 'mr9c1qugo16zic2eko', 30, 'p30_4', 0, NULL, NULL, NULL, 'Ricardo Esper', '2026-09-11'),
('chk-mr9c1qugo16zic2eko-p31_1', 'mr9c1qugo16zic2eko', 31, 'p31_1', 0, NULL, NULL, NULL, 'Ricardo Esper', '2026-07-14'),
('chk-mr9c1qugo16zic2eko-p31_2', 'mr9c1qugo16zic2eko', 31, 'p31_2', 0, NULL, NULL, NULL, 'Ricardo Esper', '2026-07-15'),
('chk-mr9c1qugo16zic2eko-p31_3', 'mr9c1qugo16zic2eko', 31, 'p31_3', 0, NULL, NULL, NULL, 'Ricardo Esper', '2026-07-16'),
('chk-mr9c1qugo16zic2eko-p31_4', 'mr9c1qugo16zic2eko', 31, 'p31_4', 0, NULL, NULL, NULL, 'Ricardo Esper', '2026-07-17'),
('chk-mr9c1qugo16zic2eko-p31_5', 'mr9c1qugo16zic2eko', 31, 'p31_5', 0, NULL, NULL, NULL, 'Ricardo Esper', '2026-07-18'),
('chk-mr9c1qugo16zic2eko-p31_6', 'mr9c1qugo16zic2eko', 31, 'p31_6', 0, NULL, NULL, NULL, 'Ricardo Esper', '2026-07-19'),
('chk-mr9c1qugo16zic2eko-p31_7', 'mr9c1qugo16zic2eko', 31, 'p31_7', 0, NULL, NULL, NULL, 'Ricardo Esper', '2026-07-20'),
('chk-mr9c1qugo16zic2eko-p31_8', 'mr9c1qugo16zic2eko', 31, 'p31_8', 0, NULL, NULL, NULL, 'Ricardo Esper', '2026-07-21'),
('chk-mr9c1qugo16zic2eko-p32_1', 'mr9c1qugo16zic2eko', 32, 'p32_1', 0, NULL, NULL, NULL, 'Ricardo Esper', '2026-07-24'),
('chk-mr9c1qugo16zic2eko-p32_2', 'mr9c1qugo16zic2eko', 32, 'p32_2', 0, NULL, NULL, NULL, 'Ricardo Esper', '2026-07-25'),
('chk-mr9c1qugo16zic2eko-p32_3', 'mr9c1qugo16zic2eko', 32, 'p32_3', 0, NULL, NULL, NULL, 'Ricardo Esper', '2026-07-26'),
('chk-mr9c1qugo16zic2eko-p32_4', 'mr9c1qugo16zic2eko', 32, 'p32_4', 0, NULL, NULL, NULL, 'Ricardo Esper', '2026-07-27'),
('chk-mr9c1qugo16zic2eko-p33_1', 'mr9c1qugo16zic2eko', 33, 'p33_1', 0, NULL, NULL, NULL, 'Kacio Lopes', '2026-09-02'),
('chk-mr9c1qugo16zic2eko-p33_2', 'mr9c1qugo16zic2eko', 33, 'p33_2', 0, NULL, NULL, NULL, 'Kacio Lopes', '2026-09-03'),
('chk-mr9c1qugo16zic2eko-p33_3', 'mr9c1qugo16zic2eko', 33, 'p33_3', 0, NULL, NULL, NULL, 'Kacio Lopes', '2026-09-04'),
('chk-mr9c1qugo16zic2eko-p33_4', 'mr9c1qugo16zic2eko', 33, 'p33_4', 0, NULL, NULL, NULL, 'Kacio Lopes', '2026-09-05'),
('chk-mr9c1qugo16zic2eko-p34_1', 'mr9c1qugo16zic2eko', 34, 'p34_1', 0, NULL, NULL, NULL, 'Ricardo Esper', '2026-09-08'),
('chk-mr9c1qugo16zic2eko-p34_2', 'mr9c1qugo16zic2eko', 34, 'p34_2', 0, NULL, NULL, NULL, 'Ricardo Esper', '2026-09-09'),
('chk-mr9c1qugo16zic2eko-p34_3', 'mr9c1qugo16zic2eko', 34, 'p34_3', 0, NULL, NULL, NULL, 'Ricardo Esper', '2026-09-10'),
('chk-mr9c1qugo16zic2eko-p34_4', 'mr9c1qugo16zic2eko', 34, 'p34_4', 0, NULL, NULL, NULL, 'Ricardo Esper', '2026-09-11'),
('chk-mr9c1qugo16zic2eko-p34_5', 'mr9c1qugo16zic2eko', 34, 'p34_5', 0, NULL, NULL, NULL, 'Ricardo Esper', '2026-09-12'),
('chk-mr9c1qugo16zic2eko-p34_6', 'mr9c1qugo16zic2eko', 34, 'p34_6', 0, NULL, NULL, NULL, 'Ricardo Esper', '2026-09-13'),
('chk-mr9c1qugo16zic2eko-p34_7', 'mr9c1qugo16zic2eko', 34, 'p34_7', 0, NULL, NULL, NULL, 'Ricardo Esper', '2026-09-14'),
('chk-mr9c1qugo16zic2eko-p34_8', 'mr9c1qugo16zic2eko', 34, 'p34_8', 0, NULL, NULL, NULL, 'Ricardo Esper', '2026-09-15'),
('chk-mr9c1qugo16zic2eko-p35_1', 'mr9c1qugo16zic2eko', 35, 'p35_1', 0, NULL, NULL, NULL, 'Ricardo Esper', '2026-09-18'),
('chk-mr9c1qugo16zic2eko-p35_2', 'mr9c1qugo16zic2eko', 35, 'p35_2', 0, NULL, NULL, NULL, 'Ricardo Esper', '2026-09-19'),
('chk-mr9c1qugo16zic2eko-p35_3', 'mr9c1qugo16zic2eko', 35, 'p35_3', 0, NULL, NULL, NULL, 'Ricardo Esper', '2026-09-20'),
('chk-mr9c1qugo16zic2eko-p35_4', 'mr9c1qugo16zic2eko', 35, 'p35_4', 0, NULL, NULL, NULL, 'Ricardo Esper', '2026-09-21'),
('chk-mr9c1qugo16zic2eko-p35_5', 'mr9c1qugo16zic2eko', 35, 'p35_5', 0, NULL, NULL, NULL, 'Ricardo Esper', '2026-09-22'),
('chk-mr9c1qugo16zic2eko-p36_1', 'mr9c1qugo16zic2eko', 36, 'p36_1', 0, NULL, NULL, NULL, 'Ricardo Esper', '2026-09-25'),
('chk-mr9c1qugo16zic2eko-p36_2', 'mr9c1qugo16zic2eko', 36, 'p36_2', 0, NULL, NULL, NULL, 'Ricardo Esper', '2026-09-26'),
('chk-mr9c1qugo16zic2eko-p36_3', 'mr9c1qugo16zic2eko', 36, 'p36_3', 0, NULL, NULL, NULL, 'Ricardo Esper', '2026-09-27'),
('chk-mr9c1qugo16zic2eko-p36_4', 'mr9c1qugo16zic2eko', 36, 'p36_4', 0, NULL, NULL, NULL, 'Ricardo Esper', '2026-09-28'),
('chk-mr9c1qugo16zic2eko-p37_1', 'mr9c1qugo16zic2eko', 37, 'p37_1', 0, NULL, NULL, NULL, 'Augusto Ferronato', '2026-09-03'),
('chk-mr9c1qugo16zic2eko-p37_2', 'mr9c1qugo16zic2eko', 37, 'p37_2', 0, NULL, NULL, NULL, 'Augusto Ferronato', '2026-09-04'),
('chk-mr9c1qugo16zic2eko-p37_3', 'mr9c1qugo16zic2eko', 37, 'p37_3', 0, NULL, NULL, NULL, 'Augusto Ferronato', '2026-09-05'),
('chk-mr9c1qugo16zic2eko-p37_4', 'mr9c1qugo16zic2eko', 37, 'p37_4', 0, NULL, NULL, NULL, 'Augusto Ferronato', '2026-09-06'),
('chk-mr9c1qugo16zic2eko-p37_5', 'mr9c1qugo16zic2eko', 37, 'p37_5', 0, NULL, NULL, NULL, 'Augusto Ferronato', '2026-09-07'),
('chk-mr9c1qugo16zic2eko-p37_6', 'mr9c1qugo16zic2eko', 37, 'p37_6', 0, NULL, NULL, NULL, 'Augusto Ferronato', '2026-09-08'),
('chk-mr9c1qugo16zic2eko-p38_1', 'mr9c1qugo16zic2eko', 38, 'p38_1', 0, NULL, NULL, NULL, 'Nizar Elouaer', '2026-09-11'),
('chk-mr9c1qugo16zic2eko-p38_2', 'mr9c1qugo16zic2eko', 38, 'p38_2', 0, NULL, NULL, NULL, 'Nizar Elouaer', '2026-09-12'),
('chk-mr9c1qugo16zic2eko-p38_3', 'mr9c1qugo16zic2eko', 38, 'p38_3', 0, NULL, NULL, NULL, 'Nizar Elouaer', '2026-09-13'),
('chk-mr9c1qugo16zic2eko-p38_4', 'mr9c1qugo16zic2eko', 38, 'p38_4', 0, NULL, NULL, NULL, 'Nizar Elouaer', '2026-09-14'),
('chk-mr9c1qugo16zic2eko-p39_1', 'mr9c1qugo16zic2eko', 39, 'p39_1', 0, NULL, NULL, NULL, 'Rosa Correia', '2026-09-17'),
('chk-mr9c1qugo16zic2eko-p39_2', 'mr9c1qugo16zic2eko', 39, 'p39_2', 0, NULL, NULL, NULL, 'Rosa Correia', '2026-09-18'),
('chk-mr9c1qugo16zic2eko-p39_3', 'mr9c1qugo16zic2eko', 39, 'p39_3', 0, NULL, NULL, NULL, 'Rosa Correia', '2026-09-19'),
('chk-mr9c1qugo16zic2eko-p39_4', 'mr9c1qugo16zic2eko', 39, 'p39_4', 0, NULL, NULL, NULL, 'Rosa Correia', '2026-09-20'),
('chk-mr9c1qugo16zic2eko-p40_1', 'mr9c1qugo16zic2eko', 40, 'p40_1', 0, NULL, NULL, NULL, 'Ricardo Esper', '2026-09-23'),
('chk-mr9c1qugo16zic2eko-p40_2', 'mr9c1qugo16zic2eko', 40, 'p40_2', 0, NULL, NULL, NULL, 'Ricardo Esper', '2026-09-24'),
('chk-mr9c1qugo16zic2eko-p40_3', 'mr9c1qugo16zic2eko', 40, 'p40_3', 0, NULL, NULL, NULL, 'Ricardo Esper', '2026-09-25')
ON CONFLICT(project_id, phase_number, item_id) DO UPDATE SET is_checked = excluded.is_checked, checked_by = excluded.checked_by, checked_at = excluded.checked_at, notes = excluded.notes, assigned_to = excluded.assigned_to, due_date = excluded.due_date;
PRAGMA foreign_keys = ON;
