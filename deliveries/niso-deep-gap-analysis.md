# 🕵️ Deep Gap Analysis & Architectural Review: nISO Portal
**Data:** 2026-07-02
**Status:** Internal Shadow Audit (Pre-Certification)

## 🎯 Objetivo
Avaliar a robustez do nISO como **Portal de Implementação Agêntica** e identificar os gaps que podem ser explorados por um auditor externo rigoroso.

---

## 1. Gaps Técnicos (Engine de Snapshot)

### 🔴 Riscos Críticos (P1)
- **Falsos Positivos no CI/CD:** O `CICDScannerService` busca por palavras-chave (ex: "Semgrep"). Um auditor pode questionar: *"E se o arquivo YAML tiver a palavra mas a ferramenta estiver comentada ou falhando?"*. 
  - **Gap:** Falta validação do **resultado** do scan (Parsed Result) em vez de apenas a presença da ferramenta.
- **Statelessness das Evidências:** Como estamos em modo MVP/Stateless, as evidências são "vivas". Se o banco de dados Neon não estiver persistindo o **Hash SHA-256** do arquivo no momento do snapshot, o auditor dirá que a evidência não tem integridade.

### 🟡 Riscos Médios (P2)
- **Escopo do Cloud Scan:** Atualmente focamos em Cloudflare. Um ambiente real terá AWS/Azure/GCP.
  - **Gap:** Precisamos de adaptadores para outros provedores para garantir a "Diligência Profunda" em infraestruturas híbridas.

---

## 2. Gaps de Conformidade (ISO 27001 / 27701)

### 🔴 Riscos Críticos (P1)
- **Cláusula 9.2 (Auditoria Interna):** O portal facilita a coleta, mas o "Relatório de Auditoria Interna" ainda é gerado via template.
  - **Gap:** O auditor quer ver a **independência**. O portal precisa provar que quem coletou a evidência (Agente) não é o mesmo que a aprovou (Consultor).
- **ISO 27701 (RoPA):** O mapeamento de dados (DREAM/RoPA) é agêntico, mas e o **Consentimento**?
  - **Gap:** Não temos uma interface para provar a gestão de consentimento (A.7.3.2 da 27701).

### 🟡 Riscos Médios (P2)
- **Gestão de Mudanças (A.8.32):** Registramos o Hotfix, mas não o processo de aprovação da mudança antes dela ocorrer.
  - **Gap:** O portal precisa de um mini-fluxo de "Change Request" para ser 100% compliant.

---

## 3. Gaps de Experiência e Diligência (Stakeholders)

### 🔴 Riscos Críticos (P1)
- **Evasão nas Entrevistas:** Como identificado no Grill, se o Stakeholder for vago e o consultor não intervir, a evidência é nula.
  - **Gap:** Precisamos de um dashboard de **"Qualidade da Evidência"** (Score de 0 a 10) para cada entrevista.

### 🟡 Riscos Médios (P2)
- **Treinamento (A.6.3):** Mostramos 85% de cobertura, mas o auditor pedirá o **conteúdo** do treinamento.
  - **Gap:** O portal deve armazenar o SCORM ou PDF do material didático usado.

---

## 🛡️ Plano de Mitigação (Roadmap de Correção)

1. **Imutabilidade Real:** Integrar o hashing de arquivos no `EvidenceService` imediatamente.
2. **Result Parsing:** Evoluir o `CICDScanner` para ler os arquivos de log de saída (SARIF/JSON) das ferramentas de segurança.
3. **Audit Trail Refinado:** O log de transparência deve incluir o "Porquê" (Justificativa de Negócio) para cada alteração.
4. **Consent Vault:** Adicionar um módulo simples para upload de termos de consentimento para a ISO 27701.

---

## 📢 Conclusão do Revisor
O nISO é uma "arma" poderosa de implementação, mas sua fraqueza atual é a **confiança cega na automação**. Para chegar na certificação, o portal deve se tornar mais **cético**, exigindo provas de que o que ele encontrou no código realmente funcionou e foi revisado por um humano.
