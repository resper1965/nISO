-- Migration 0025: trilha por CAMPO.
--
-- `audit_logs.details` é texto livre: diz que "o controle X foi atualizado",
-- não O QUE mudou. O auditor precisa de `campo: antes → depois`, e a tela de
-- histórico do controle não tem de onde tirar isso.
--
-- Colunas aditivas e nullable: toda chamada existente de `logAudit` continua
-- válida e grava só `details`, como antes. Nada é reescrito.
--
-- `operation_id` agrupa a operação: uma ação em lote sobre 3 controles gera 3
-- linhas com o mesmo id, e é assim que a tela sabe dizer "em lote (3 controles)".
-- É também o que liga uma operação ao registro de que ela foi desfeita — o
-- desfazer NÃO apaga linha nenhuma, porque a tabela é append-only por trigger.

ALTER TABLE audit_logs ADD COLUMN entity_type TEXT;
ALTER TABLE audit_logs ADD COLUMN entity_id TEXT;
ALTER TABLE audit_logs ADD COLUMN field TEXT;
ALTER TABLE audit_logs ADD COLUMN old_value TEXT;
ALTER TABLE audit_logs ADD COLUMN new_value TEXT;
ALTER TABLE audit_logs ADD COLUMN operation_id TEXT;

-- A tela de histórico do controle lê por entidade; o agrupamento de lote e o
-- desfazer leem por operação.
CREATE INDEX IF NOT EXISTS idx_audit_logs_entity ON audit_logs(entity_type, entity_id, created_at);
CREATE INDEX IF NOT EXISTS idx_audit_logs_operation ON audit_logs(operation_id);
