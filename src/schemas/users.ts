import { z } from 'zod';

/**
 * Os papéis que a plataforma reconhece. Lista fechada, e não `z.string()`.
 *
 * `users.role` é TEXT livre no schema, e enquanto a validação também era livre
 * qualquer palavra virava papel. O problema não é a linha estranha no banco — é
 * que as guardas de escrita são LISTAS DE NEGAÇÃO, não de permissão:
 *
 *     if (user.role === 'org_user' || user.role === 'client') { ...bloqueia... }
 *
 * Um papel que ninguém reconhece não casa com essa condição e passa direto.
 * Quer dizer: criar alguém como `ciso` — ou como `org_user`, com o dedo trocado
 * — dava MAIS poder de escrita que criar como `org_user`, calado e sem erro
 * nenhum. O isolamento de tenant continuava valendo (`requireProjectAccess`
 * falha fechado para papel desconhecido), mas dentro do próprio projeto a
 * pessoa escrevia o que o papel pretendido não deixaria.
 *
 * Cada nome aqui tem contrapartida em código que o testa:
 *   - `platform_admin` opera a plataforma — e por isso mesmo não assina
 *     conformidade nela (ver `autoridadeDeAssinatura` em helpers.ts);
 *   - `consultor` entrega serviço ao cliente e assina o papel que a matriz de
 *     governança do PROJETO lhe der;
 *   - `org_admin` administra os usuários do próprio cliente;
 *   - `org_user` e `client` são de leitura, com escrita só no allow-list de
 *     `authMiddleware`.
 *
 * As grafias legadas (`admin`, `user`, `consultant`, `client_admin`) NÃO entram:
 * `authMiddleware` as traduz para linhas que já existem no banco, e aceitá-las
 * na entrada seria continuar produzindo o que aquela tradução existe para
 * limpar. Uma letra de diferença entre `consultant` e `consultor` já decidiu,
 * uma vez, se a conta era administrador de plataforma.
 */
export const PAPEIS_DE_USUARIO = ['platform_admin', 'consultor', 'org_admin', 'org_user', 'client'] as const;

export const papelDeUsuario = z.enum(PAPEIS_DE_USUARIO, {
  error: `Papel inválido. Use um de: ${PAPEIS_DE_USUARIO.join(', ')}`,
});

export const createUserSchema = z.object({
  email: z.string().email('E-mail inválido'),
  password: z.string().min(1, 'Senha é obrigatória'),
  name: z.string().min(1, 'Nome é obrigatório'),
  role: papelDeUsuario,
  client_project_id: z.string().nullable().optional()
});

export const updateUserSchema = z.object({
  name: z.string().min(1).optional(),
  // `email` faltava aqui e o handler o atualiza. Como este schema não era usado
  // por ninguém, ninguém notou; ligado ao PUT sem esta linha, trocar e-mail
  // passaria a ser silenciosamente ignorado.
  email: z.string().email('E-mail inválido').optional(),
  role: papelDeUsuario.optional(),
  password: z.string().optional(),
  client_project_id: z.string().nullable().optional()
});
