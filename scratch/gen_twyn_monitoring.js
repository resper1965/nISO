
const fs = require('fs');
const projectId = 'twyn-27001';

let sql = `-- TWYN Fine-grained Migration: Cadence and Monitoring\n`;

// 1. Update Project Status and metadata based on Status Report
sql += `UPDATE projects SET 
  status = 'active',
  sector = 'SaaS / Fintech',
  scope = 'ISMS encompassing all TWYN cloud infrastructure and product development CI/CD pipelines',
  standards = 'ISO 27001:2022, ISO 27701'
WHERE id = '${projectId}';\n`;

// 2. Update Phases status
// Journey 1: Foundation (0-6) -> completed
for (let i = 0; i <= 6; i++) {
    sql += `UPDATE project_phases SET status = 'completed' WHERE project_id = '${projectId}' AND phase_number = ${i};\n`;
}
// Journey 2: Discovery (7-13) -> completed
for (let i = 7; i <= 13; i++) {
    sql += `UPDATE project_phases SET status = 'completed' WHERE project_id = '${projectId}' AND phase_number = ${i};\n`;
}
// Journey 3/4: Implementation/Privacy (14-28) -> in_progress
for (let i = 14; i <= 28; i++) {
    sql += `UPDATE project_phases SET status = 'in_progress' WHERE project_id = '${projectId}' AND phase_number = ${i};\n`;
}

// 3. Audit Schedule (Cadence)
const audits = [
    { id: 'audit-twyn-1', type: 'Internal', title: 'Auditoria Interna de Governança', date: '2026-05-20', status: 'completed', findings: 3, notes: 'Foco em cláusulas 4 a 10 e políticas básicas.' },
    { id: 'audit-twyn-2', type: 'Management Review', title: 'Ata de Revisão pela Direção Q2', date: '2026-06-02', status: 'completed', findings: 0, notes: 'Aprovação formal do SGSI pela diretoria.' },
    { id: 'audit-twyn-3', type: 'Technical', title: 'Vulnerability Scan & AWS Review', date: '2026-06-15', status: 'scheduled', findings: 0, notes: 'Verificação de fechamento de gaps técnicos.' },
    { id: 'audit-twyn-4', type: 'External Stage 1', title: 'Auditoria de Certificação - Fase 1', date: '2026-07-10', status: 'scheduled', findings: 0, notes: 'Auditoria documental pela certificadora.' },
    { id: 'audit-twyn-5', type: 'External Stage 2', title: 'Auditoria de Certificação - Fase 2', date: '2026-08-15', status: 'scheduled', findings: 0, notes: 'Auditoria operacional e de evidências.' }
];

audits.forEach(a => {
    sql += `INSERT INTO audit_schedule (id, project_id, audit_type, title, scheduled_date, auditor_name, status, findings_count, notes)
            VALUES ('${a.id}', '${projectId}', '${a.type}', '${a.title}', '${a.date}', 'Ricardo Esper', '${a.status}', ${a.findings}, '${a.notes}')
            ON CONFLICT(id) DO NOTHING;\n`;
});

// 4. Corrective Actions (CAPAs) from GAPs
const capas = [
    { id: 'capa-twyn-1', title: 'Enable MFA on AWS root account', desc: 'AWS root account does not have MFA enabled', status: 'open', severity: 'critical' },
    { id: 'capa-twyn-2', title: 'Rotate IAM access keys > 90 days', desc: 'IAM user tmpsaasboost keys are stale', status: 'open', severity: 'high' },
    { id: 'capa-twyn-3', title: 'Test backup restoration (DR)', desc: 'Backups exist but restoration never tested', status: 'in_progress', severity: 'critical' }
];

capas.forEach(c => {
    sql += `INSERT INTO corrective_actions (id, project_id, title, description, status, severity, created_at)
            VALUES ('${c.id}', '${projectId}', '${c.title}', '${c.desc}', '${c.status}', '${c.severity}', '2026-06-03')
            ON CONFLICT(id) DO NOTHING;\n`;
});

fs.writeFileSync('C:\\Users\\resper\\.gemini\\antigravity\\brain\\7b1d620d-8d62-4f19-af2e-7a65fc5b9749\\scratch\\twyn_monitoring.sql', sql);
console.log("Monitoring SQL generated.");
