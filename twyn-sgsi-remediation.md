# Plano de Regularização do SGSI — API TWYN

## Goal
Regularizar a consistência do fluxo de governança e auditoria (PDCA) do SGSI da API TWYN, implementando os controles de engenharia pendentes e colhendo as evidências necessárias para a certificação.

## Tasks
- [ ] Task 1: Reverter status da Fase 31 (Auditoria Interna) e Fase 32 (Análise Crítica) para `in_progress` no D1 remoto → Verify: Executar query no D1 e ver status como `in_progress`.
- [ ] Task 2: Gerar políticas específicas de segurança para a API (A.8.25 Dev Seguro, A.8.28 Codificação Segura e A.8.24 Criptografia) usando o PolicyAgent → Verify: Chamar API `/generate-policy` e obter os markdowns gerados.
- [ ] Task 3: Registrar aprovação e assinatura digital do CISO (Bianca Lopes) e CEO (Kacio Lopes) nos novos controles da API → Verify: Query em `compliance_controls` mostra campos `ciso_approved_by` e `ceo_approved_by` preenchidos.
- [ ] Task 4: Subir evidências técnicas reais de pipelines de CI/CD (SAST/DAST) e configurações KMS no Evidence Vault → Verify: Registros inseridos na tabela `evidence` com hashes SHA-256 válidos.
- [ ] Task 5: Finalizar a execução e checklists pendentes das Fases 15 a 30 (Implementação Operacional) → Verify: Percentual de progresso do dashboard das respectivas fases em 100%.
- [ ] Task 6: Re-executar e concluir a Auditoria Interna (Fase 31) gerando relatórios de conformidade e achados formais → Verify: Status da Fase 31 definido como `completed` com registros na tabela `audit_findings`.
- [ ] Task 7: Conduzir e fechar a Reunião de Análise Crítica da Direção (Fase 32) compilando as atas da API → Verify: Rota GET `/management-reviews` retorna a ata e decisões salvas.
- [ ] Task 8: Gerar e exportar o Audit Readiness Pack consolidado para envio à certificadora → Verify: Download do JSON via `/projects/mr9c1qugo16zic2eko/audit-pack` executado com sucesso.

## Done When
- [ ] O fluxo PDCA do SGSI do projeto TWYN estiver 100% íntegro e sem inconsistências cronológicas.
- [ ] O Audit Readiness Pack contendo todas as políticas assinadas, evidências de SDLC e logs da API estiver gerado e disponível para o auditor externo.

## Notes
- A regularização das Fases 31 e 32 é mandatória para evitar uma Não Conformidade Maior no Estágio 1 da auditoria de certificação.
- As tarefas de engenharia (CI/CD, logs e criptografia) devem priorizar os endpoints expostos da API de biometria facial.
