import { describe, it, expect } from 'vitest';
import { authorizeApiKey } from '../src/auth-policy';

// Testa a decisão de autorização por papel de API key (função pura).
describe('authorizeApiKey — separação de papéis', () => {
  const P = '/api/v1/projects/PROJ-1';
  const GEN_POLICY = '/api/v1/projects/PROJ-1/generate-policy';
  const FINDINGS = '/api/v1/audits/AUD-1/findings';
  const NOTES = '/api/v1/auditor/tok/notes';

  it('leitura é liberada para todos os papéis', () => {
    for (const role of ['consultor', 'auditor', 'apikey_readonly']) {
      expect(authorizeApiKey(role, null, 'GET', P).ok).toBe(true);
    }
  });

  it('auditor NÃO gera política (implementação)', () => {
    const d = authorizeApiKey('auditor', null, 'POST', GEN_POLICY);
    expect(d.ok).toBe(false);
  });

  it('auditor PODE registrar achado e nota', () => {
    expect(authorizeApiKey('auditor', null, 'POST', FINDINGS).ok).toBe(true);
    expect(authorizeApiKey('auditor', null, 'POST', NOTES).ok).toBe(true);
  });

  it('consultor gera política mas NÃO registra achado de auditoria', () => {
    expect(authorizeApiKey('consultor', null, 'POST', GEN_POLICY).ok).toBe(true);
    expect(authorizeApiKey('consultor', null, 'POST', FINDINGS).ok).toBe(false);
  });

  it('apikey_readonly recusa qualquer escrita', () => {
    expect(authorizeApiKey('apikey_readonly', null, 'POST', GEN_POLICY).ok).toBe(false);
    expect(authorizeApiKey('apikey_readonly', null, 'GET', P).ok).toBe(true);
  });

  it('papel desconhecido é negado (least privilege)', () => {
    expect(authorizeApiKey('qualquer', null, 'GET', P).ok).toBe(false);
  });

  describe('escopo de projeto', () => {
    it('chave presa a PROJ-1 recusa PROJ-2', () => {
      const d = authorizeApiKey('consultor', 'PROJ-1', 'GET', '/api/v1/projects/PROJ-2/controls');
      expect(d.ok).toBe(false);
    });
    it('chave presa a PROJ-1 aceita PROJ-1', () => {
      expect(authorizeApiKey('consultor', 'PROJ-1', 'GET', '/api/v1/projects/PROJ-1/controls').ok).toBe(true);
    });
    it('chave presa a um projeto recusa o portfólio', () => {
      expect(authorizeApiKey('auditor', 'PROJ-1', 'GET', '/api/v1/portfolio').ok).toBe(false);
    });
    it('chave sem escopo aceita o portfólio', () => {
      expect(authorizeApiKey('consultor', null, 'GET', '/api/v1/portfolio').ok).toBe(true);
    });
  });
});
