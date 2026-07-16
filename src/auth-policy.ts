// Política de autorização de API keys de agente — FUNÇÃO PURA, sem dependências.
// Isolada para ser testável sem carregar o worker inteiro.
//
// Espelha no backend a separação de papéis da camada MCP:
//  - apikey_readonly: só leitura;
//  - auditor: leitura + achados/notas de auditoria; nunca implementação;
//  - consultor: implementação; nunca registra achado de auditoria.
// Escopo de projeto: chave presa a um projeto não toca outro nem lista o portfólio.

export function authorizeApiKey(
  role: string,
  clientProjectId: string | null,
  method: string,
  path: string
): { ok: boolean; error?: string } {
  const isWrite = method !== 'GET' && method !== 'HEAD' && method !== 'OPTIONS';
  const isAuditWrite =
    method === 'POST' &&
    (/^\/api\/v1\/audits\/[^\/]+\/findings/.test(path) ||
      /^\/api\/v1\/auditor\/[^\/]+\/notes/.test(path));

  // Escopo de projeto (vale para todos os papéis de key).
  if (clientProjectId) {
    const projectMatch = path.match(/\/api\/v1\/projects\/([^\/]+)/);
    if (projectMatch && projectMatch[1] !== clientProjectId) {
      return { ok: false, error: 'Forbidden: API key restrita a outro projeto' };
    }
    if (path.startsWith('/api/v1/portfolio')) {
      return { ok: false, error: 'Forbidden: API key restrita a um projeto (sem portfólio)' };
    }
  }

  if (role === 'apikey_readonly') {
    return isWrite
      ? { ok: false, error: 'Forbidden: API key somente leitura' }
      : { ok: true };
  }
  if (role === 'auditor') {
    return isWrite && !isAuditWrite
      ? { ok: false, error: 'Forbidden: auditor só escreve achados/notas de auditoria' }
      : { ok: true };
  }
  if (role === 'consultor') {
    return isAuditWrite
      ? { ok: false, error: 'Forbidden: consultor não registra achado de auditoria' }
      : { ok: true };
  }
  return { ok: false, error: 'Forbidden: papel de API key desconhecido' };
}
