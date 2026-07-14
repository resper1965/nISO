# Plano de Melhorias de Interface e UX/UI — nISO

## Goal
Implementar melhorias funcionais e de usabilidade no SPA Vanilla JS (`frontend/dist/index.html`) para otimizar o fluxo de certificação ISO 27001 da TWYN, alinhando a interface com as diretrizes de design da ness. (Inter/Montserrat, glassmorphism, sem emojis) e os requisitos normativos.

---

## Fase 1: Painel DoD (Definition of Done) & Modal de Pendências
Substituir o `confirm()` nativo do navegador por uma gaveta/modal nativa e estilizada contendo ações diretas.

- [ ] Task 1.1: Localizar a função `changePhaseStatus` em `frontend/dist/index.html` (aproximadamente linha 1703) → Verify: Confirmar a linha da assinatura da função.
- [ ] Task 1.2: Desenvolver a função helper `openDoDDrawer(projectId, phaseNum, selectEl, pendingItens)` que injeta no DOM o modal com visual glassmorphism (`backdrop-filter: blur(24px)`) → Verify: Injetar e abrir o modal no clique sem erros.
- [ ] Task 1.3: Adicionar na lista de pendências do modal botões contextuais "Gerar com IA" (chamando `openGeneratePolicyModal`) e "Upload" (para evidências) → Verify: Clicar no botão de geração e ver o modal de IA abrir corretamente.
- [ ] Task 1.4: Adaptar o fluxo de confirmação para alterar o status da fase após a decisão do usuário no novo modal → Verify: Confirmar conclusão e ver a fase atualizar no D1.

---

## Fase 2: Filtros Inteligentes e Rastreabilidade Integrada no SoA
Adicionar filtros avançados e colunas de rastreabilidade (Riscos e Evidências vinculados) no Statement of Applicability.

- [ ] Task 2.1: Localizar a função `renderSoA` (linha 2670) no arquivo `frontend/dist/index.html` → Verify: Identificar o cabeçalho e a renderização do grid de seções.
- [ ] Task 2.2: Implementar o painel de filtros rápidos (Aplicáveis, Não Aplicáveis, Gaps, Aprovados) e busca em tempo real acima da tabela → Verify: Digitar termo ou alterar filtro e ver as linhas ocultarem/exibirem instantaneamente.
- [ ] Task 2.3: Atualizar a consulta da listagem de controles ou realizar join/lookup em memória das tabelas de riscos e evidências associadas ao projeto → Verify: Ter arrays de riscos e evidências disponíveis no escopo de renderização do SoA.
- [ ] Task 2.4: Renderizar na linha de cada controle a coluna "Rastreabilidade" com badges contendo a quantidade de riscos e arquivos anexados → Verify: Visualizar os badges de riscos e documentos no SoA.

---

## Fase 3: Matriz de Riscos Térmica & Interativa
Substituir a listagem em tabela de riscos por um painel analítico com gráfico 5x5 térmico.

- [ ] Task 3.1: Criar a função `renderRiskMatrixGrid()` dentro da view de Riscos para desenhar a matriz térmica 5x5 usando CSS Grid e o gradiente de cores institucionais (sem ícones) → Verify: Matriz 5x5 exibida no cabeçalho da seção de Riscos.
- [ ] Task 3.2: Mapear os riscos ativos do projeto nos quadrantes da matriz térmico com contadores numéricos → Verify: Total de riscos distribuídos na matriz bate com a soma da tabela.
- [ ] Task 3.3: Adicionar evento de clique nos quadrantes para filtrar dinamicamente as linhas da tabela de riscos detalhada exibida abaixo → Verify: Clicar no quadrante crítico e ver apenas riscos de alta severidade na tabela.

---

## Fase 4: Workflow de Assinatura das Evidências (Evidence Vault)
Formalizar e registrar assinaturas de conformidade (CISO e CEO) nas evidências do projeto.

- [ ] Task 4.1: Adicionar colunas `ciso_approved_by`, `ciso_approved_at`, `ceo_approved_by`, `ceo_approved_at` na tabela `evidence` do `schema.sql` e rodar o ALTER TABLE correspondente → Verify: Rodar queries de alter no D1 remoto.
- [ ] Task 4.2: Atualizar a listagem de evidências no frontend para exibir as assinaturas e botões "Assinar como CISO" e "Assinar como CEO" para usuários autorizados → Verify: Botões visíveis apenas para perfis elegíveis.
- [ ] Task 4.3: Implementar rota no backend `PUT /api/v1/evidence/:id/sign` para persistir as aprovações no D1 → Verify: Chamar rota via PUT e validar persistência das colunas.

---

## Fase 5: Central de Alertas Acionáveis
Vincular mensagens e notificações diretamente a ações e modais no frontend.

- [ ] Task 5.1: Localizar o renderizador do painel de notificações no cabeçalho do `frontend/dist/index.html` → Verify: Identificar a função de render do dropdown.
- [ ] Task 5.2: Injetar metadados de destino (ex: `action_type: 'auditor_notes', target_id: 'A.5.15'`) na rota de envio/criação de notificações no backend → Verify: Notificações criadas com propriedades de redirecionamento.
- [ ] Task 5.3: Mapear o clique da notificação para disparar a função correspondente (ex: abrir modal de notas do auditor ou navegar para aba correta) em vez de apenas ler o texto → Verify: Clicar no alerta e ver o modal ou aba abrir de forma contextual instantaneamente.

---

## Done When
- [ ] Todas as 5 fases de melhoria estiverem implementadas no `frontend/dist/index.html` e `src/index.ts`.
- [ ] Toda a interface estiver alinhada estritamente com as regras estéticas da ness. (Montserrat headings, Inter body, glassmorphism, sem emojis, paleta escura).
- [ ] O projeto da TWYN for testado de ponta a ponta sem falhas de fluxo.
