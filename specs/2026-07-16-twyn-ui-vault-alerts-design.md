# Especificação de Design: DoD Drawer, Matriz 5x5, Vault de Assinatura e Alertas Contextuais
**nISO Agentic GRC System — TWYN Integrations Spec**

---
**Controle do Documento**
| Campo | Valor |
|-------|-------|
| **Document ID** | SGSI-SPEC-003 |
| **Version** | 1.0 (Design Aprovado) |
| **Data de Criação**| 16/07/2026 |
| **Autores** | Ricardo Esper (DPO & Consultor Perito) |
| **Status** | Aprovado para Planejamento |
---

## 1. Introdução & Objetivos

Este documento especifica a arquitetura e os padrões visuais para a implementação de três Sprints de melhorias técnicas e de usabilidade no portal nISO da TWYN. O foco do design é a simplicidade operacional (filosofia PonyTail/YAGNI), sem overkill tecnológico e maximizando o reuso do estado local da SPA Vanilla JS (`window.S`) e as rotas Hono.

---

## 2. Sprint 1: Painel DoD (Definition of Done) & Rastreabilidade no SoA

### 2.1 Gaveta DoD (DoD Drawer)
*   **Comportamento**: Ao clicar no botão para avançar ou alterar o status de uma fase (função `changePhaseStatus` no frontend), o sistema verifica se há controles `Missing` ou evidências pendentes mapeadas para aquela fase. Em caso de pendências, bloqueia a mudança e desliza a gaveta de DoD da direita.
*   **Aparência Visual**: Visual glassmorphic escuro (`background: rgba(15, 23, 42, 0.8)`, `backdrop-filter: blur(24px)`, borda sutil com `rgba(255,255,255,0.08)` e sombra difusa).
*   **Mapeamento por Regex (PonyTail)**:
    *   O frontend itera sobre os itens de checklist da fase correspondente.
    *   Extrai a referência dos controles usando a Regex `/A\.\d+\.\d+/g`.
    *   Faz o lookup nos controles ativos do projeto (`S.activeProjectControls`).
    *   Exibe na gaveta apenas os controles que estiverem em estado `Missing` (com botão acionável "Gerar com IA") ou que não possuam arquivos vinculados (com botão "Upload").
*   **Integração de Ações**:
    *   "Gerar com IA": Aciona a função preexistente `openPolicyGeneratorModal(controlId)`.
    *   "Upload": Aciona o input de arquivo de evidência mapeado para o controle.

### 2.2 Rastreabilidade no SoA
*   **Interface**: Nova coluna "Rastreabilidade" adicionada à tabela gerada pela função `renderSoA`.
*   **Badges de Relação**:
    *   `[Riscos: X]` (Badge Azul-Escuro): Exibido se houver riscos mapeados mitigados pelo controle.
    *   `[Evidências: Y]` (Badge Verde-Esmeralda): Exibido se houver evidências associadas ao controle. O clique abre um mini-vault visual daquele controle.
    *   `[DPO ✓] [CEO ✓]` (Badges Verdes): Indicadores discretos de que Ricardo Esper e Kacio Lopes aprovaram/assinaram digitalmente o controle.

---

## 3. Sprint 2: Matriz de Riscos 5x5 & Evidence Vault

### 3.1 Matriz de Riscos Térmica 5x5
*   **Renderização**: Um grid CSS de 5 colunas x 5 linhas inserido no topo da seção de Riscos (`renderRiskMatrixGrid`).
*   **Cores Térmicas (ness. design)**: Tons opacos e discretos de background:
    *   Baixo (verde-suave): Impacto/Probabilidade 1x1, 1x2, 2x1.
    *   Médio (amarelo/laranja): Células intermediárias.
    *   Crítico (vermelho-escuro): 5x5 e arredores.
*   **Interatividade**:
    *   Agrupamento em memória no array `S.risks` para preencher as contagens em cada célula.
    *   **Clique de Toggle**: Clicar em uma célula filtra a tabela detalhada abaixo. Clicar novamente na mesma célula (ou no item selecionado) remove o filtro e exibe a lista completa.

### 3.2 Evidence Vault (Assinatura Dupla)
*   **Database (D1)**: Adição das colunas `ciso_approved_by` (TEXT), `ciso_approved_at` (TEXT), `ceo_approved_by` (TEXT) e `ceo_approved_at` (TEXT) na tabela `evidence`.
*   **Backend (Hono - PUT `/api/v1/evidence/:id/sign`)**:
    *   A rota valida o token do usuário logado na sessão KV (`c.get('user')`).
    *   Se o e-mail logado corresponder a **Ricardo Esper** (DPO/Consultor), atualiza as colunas `ciso_approved_by/at`.
    *   Se o e-mail logado corresponder a **Kacio Lopes** (CEO), atualiza as colunas `ceo_approved_by/at`.
    *   Qualquer outra tentativa retorna `403 Forbidden`.
*   **Interface (Vault)**:
    *   Exibição dos botões "Assinar como DPO" e "Assinar como CEO" baseada no e-mail do usuário logado.
    *   Uma vez assinado, exibe o carimbo verde correspondente e desabilita o botão de exclusão do registro, mantendo a cadeia de custódia da evidência.

---

## 4. Sprint 3: Central de Alertas Acionáveis & Deep-Linking

### 4.1 Alertas Contextuais
*   **Database (D1)**: Colunas `action_type` e `target_id` persistidas na tabela `notifications`.
*   **Deep-Linking**: O clique em um alerta no dropdown de notificações do header intercepta o redirecionamento:
    *   `open_finding`: Navega para a aba de CAPAs (`navigate('capas')`) e abre o modal de edição correspondente ao `target_id`.
    *   `open_soa`: Navega para o SoA (`navigate('soa')`), rola até a linha correspondente ao controle (`target_id`) e dispara o efeito CSS de pulso.
*   **Efeito Visual de Pulso**:
    *   Aplica a animação CSS `@keyframes pulse-highlight` piscando em tom azul-ness (`#00ade8`) por 3 segundos na linha do controle.

---

## 5. Plano de Validação e Testes

*   **Testes Unitários de Backend (Vitest)**:
    *   Verificar se a rota `/api/v1/evidence/:id/sign` restringe assinaturas com base na identidade da sessão, retornando `403` para e-mails não autorizados.
*   **Verificação de Interface (Manual/QA)**:
    *   Toggle de filtro da Matriz 5x5 limpando o estado de filtro ao re-clicar.
    *   Deslize e renderização dinâmica da Gaveta de DoD ao bloquear fases com controles em `Missing`.
