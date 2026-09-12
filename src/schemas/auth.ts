import { z } from 'zod';

export const loginSchema = z.object({
  email: z.string().email('E-mail inválido'),
  password: z.string().min(1, 'Senha é obrigatória'),
  // Token do desafio anti-abuso. Só é exigido a partir da 2ª tentativa
  // (ver auth-policy.ts); por isso é opcional no schema.
  challengeToken: z.string().max(4096).optional()
});

export const setupSchema = z.object({
  email: z.string().email('E-mail inválido'),
  password: z.string().min(1, 'Senha é obrigatória'),
  name: z.string().min(1, 'Nome é obrigatório'),
  setupKey: z.string().optional()
});

export const resetRequestSchema = z.object({
  email: z.string().email('E-mail inválido')
});

export const resetConfirmSchema = z.object({
  token: z.string().min(1, 'Token é obrigatório'),
  newPassword: z.string().min(1, 'Nova senha é obrigatória')
});
