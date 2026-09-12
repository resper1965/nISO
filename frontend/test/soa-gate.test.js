// Gate de aplicabilidade N/A da SoA, ordenação natural do código e seleção em
// lote — `src/views/compliance.js`. O gate é requisito da norma, não estética:
// exclusão de controle sem justificativa registrada é achado de auditoria, e
// tem de ser impossível de produzir pela interface.
import { describe, it, expect, vi, beforeEach } from 'vitest';

const { apiMock } = vi.hoisted(() => ({ apiMock: vi.fn() }));
vi.mock('../src/api.js', () => ({ api: apiMock, API_BASE: 'http://localhost' }));

import '../src/views/compliance.js';
import { S } from '../src/state.js';

function montaDom() {
  document.body.innerHTML = `
    <div class="modal-overlay" id="modal-overlay">
      <div class="modal" id="modal"><div id="modal-content"></div></div>
    </div>
    <div id="content"></div><div id="header-title"></div><div id="header-actions"></div>
    <div id="live-region" role="status" aria-live="polite"></div>`;
}
const modalText = () => document.getElementById('modal-content').textContent;
const ultimoToast = () => {
  const t = document.querySelectorAll('.toast');
  return t.length ? t[t.length - 1].textContent : null;
};

beforeEach(() => {
  montaDom();
  apiMock.mockReset();
  apiMock.mockResolvedValue({});
  window.render = vi.fn();
  window.soaSel = new Set();
  window.currentSoAControls = [];
});

describe('ordenação natural do código do Anexo A', () => {
  it('A.5.7 vem antes de A.5.15 e A.8.2 antes de A.8.11', () => {
    const codigos = ['A.5.15', 'A.8.11', 'A.5.7', 'A.8.2', 'A.5.1'];
    codigos.sort(window.compareControlCode);
    expect(codigos).toEqual(['A.5.1', 'A.5.7', 'A.5.15', 'A.8.2', 'A.8.11']);
  });

  it('comparação de string produziria a ordem ERRADA — o teste existe por isso', () => {
    const porString = ['A.5.15', 'A.5.7'].sort();
    expect(porString[0]).toBe('A.5.15'); // documenta o defeito que o comparador evita
  });

  it('prefixo diferente ordena por letra antes de por número', () => {
    expect(['B.1.1', 'A.9.9'].sort(window.compareControlCode)).toEqual(['A.9.9', 'B.1.1']);
  });

  it('código mais curto vem antes do mais longo com o mesmo prefixo', () => {
    expect(['A.5.1.2', 'A.5.1'].sort(window.compareControlCode)).toEqual(['A.5.1', 'A.5.1.2']);
  });
});

describe('gate de N/A', () => {
  it('marcar N/A NAO grava direto: abre o bloco de justificativa', async () => {
    await window.toggleSoAApplicability('c1', 'Not Applicable');
    expect(apiMock).not.toHaveBeenCalled();
    expect(modalText()).toContain('Excluir do escopo');
    expect(modalText()).toContain('Justificativa da exclusão');
  });

  it('Confirmar N/A nasce desabilitado, com o motivo no title', async () => {
    await window.toggleSoAApplicability('c1', 'Not Applicable');
    const btn = document.getElementById('na-confirm');
    expect(btn.disabled).toBe(true);
    expect(btn.title).toContain('40 caracteres');
  });

  it('o contador libera o botão só a partir do mínimo', async () => {
    await window.toggleSoAApplicability('c1', 'Not Applicable');
    const ta = document.getElementById('na-why');
    const btn = document.getElementById('na-confirm');

    ta.value = 'x'.repeat(39);
    window.updateNACounter();
    expect(document.getElementById('na-counter').textContent).toBe('39/40 caracteres mínimos');
    expect(btn.disabled).toBe(true);

    ta.value = 'x'.repeat(40);
    window.updateNACounter();
    expect(btn.disabled).toBe(false);
  });

  it('espaço em branco não conta como justificativa', async () => {
    await window.toggleSoAApplicability('c1', 'Not Applicable');
    document.getElementById('na-why').value = '   '.repeat(20);
    window.updateNACounter();
    expect(document.getElementById('na-confirm').disabled).toBe(true);
  });

  it('confirmar grava a justificativa E zera a maturidade', async () => {
    await window.toggleSoAApplicability('c1', 'Not Applicable');
    const why = 'Nao ha desenvolvimento de software no escopo do SGSI.';
    document.getElementById('na-why').value = why;
    window.updateNACounter();
    await window.confirmNA('c1');

    expect(apiMock).toHaveBeenCalledWith('PUT', '/api/v1/controls/c1', {
      status: 'Not Applicable',
      description: why,
    });
    // Controle fora do escopo com CMMI 3 mentiria no relatorio.
    expect(apiMock).toHaveBeenCalledWith('PUT', '/api/v1/controls/c1/maturity', { maturity: 0 });
  });

  it('confirmar abaixo do mínimo não chama a API, nem se forçado', async () => {
    await window.toggleSoAApplicability('c1', 'Not Applicable');
    document.getElementById('na-why').value = 'curto demais';
    await window.confirmNA('c1');
    expect(apiMock).not.toHaveBeenCalled();
  });

  it('voltar para Aplicável é livre: não remove nada da SoA', async () => {
    await window.toggleSoAApplicability('c1', 'Applicable');
    expect(apiMock).toHaveBeenCalledWith('PUT', '/api/v1/controls/c1', { status: 'Missing' });
  });

  it('apagar a justificativa de um controle N/A é recusado', async () => {
    window.currentSoAControls = [{ id: 'c1', status: 'Not Applicable', description: 'motivo registrado' }];
    await window.saveSoAJustification('c1', '   ');
    expect(apiMock).not.toHaveBeenCalled();
    expect(ultimoToast()).toContain('não pode ficar sem justificativa');
  });

  it('em controle aplicável a nota pode ficar vazia — ali não é justificativa', async () => {
    window.currentSoAControls = [{ id: 'c1', status: 'Missing', description: 'nota antiga' }];
    await window.saveSoAJustification('c1', '');
    expect(apiMock).toHaveBeenCalledWith('PUT', '/api/v1/controls/c1', { description: '' });
  });
});

describe('bloqueio da produção da SoA', () => {
  it('N/A sem justificativa bloqueia; N/A com justificativa não', () => {
    expect(window.naSemJustificativa({ status: 'Not Applicable', description: '' })).toBe(true);
    expect(window.naSemJustificativa({ status: 'Not Applicable', description: '   ' })).toBe(true);
    expect(window.naSemJustificativa({ status: 'Not Applicable' })).toBe(true);
    expect(window.naSemJustificativa({ status: 'Not Applicable', description: 'Fora do escopo.' })).toBe(false);
  });

  it('controle aplicável sem descrição NÃO bloqueia', () => {
    expect(window.naSemJustificativa({ status: 'Missing', description: '' })).toBe(false);
    expect(window.naSemJustificativa({ status: 'Implemented' })).toBe(false);
  });

  // O piso de 40 caracteres vale para justificativa NOVA, digitada por pessoa.
  // As geradas pelo SoALogicEngine sao curtas de proposito ("No software
  // development activities." tem 35) e travar a exportacao por causa delas
  // bloquearia todo projeto existente sem ganho de conformidade.
  it('justificativa curta já gravada não bloqueia: a norma exige registro, não 40 caracteres', () => {
    expect(window.naSemJustificativa({
      status: 'Not Applicable',
      description: 'No software development activities.',
    })).toBe(false);
  });
});

describe('seleção em lote', () => {
  beforeEach(() => {
    window.currentSoAControls = [
      { id: 'c1', status: 'Missing' },
      { id: 'c2', status: 'Partial' },
      { id: 'c3', status: 'Not Applicable', description: 'fora do escopo' },
    ];
  });

  it('a barra aparece com seleção e some quando zera', () => {
    expect(document.getElementById('soa-batch-bar')).toBeNull();
    window.toggleSoASelection('c1', true);
    expect(document.getElementById('soa-batch-bar')).not.toBeNull();
    window.toggleSoASelection('c1', false);
    expect(document.getElementById('soa-batch-bar')).toBeNull();
  });

  it('Marcar N/A fica DESABILITADO: justificativa de exclusão é individual', () => {
    window.toggleSoASelection('c1', true);
    const btn = Array.from(document.querySelectorAll('#soa-batch-bar button'))
      .find(b => b.textContent.includes('Marcar N/A'));
    expect(btn.disabled).toBe(true);
    expect(btn.title).toContain('individual');
  });

  it('marcar implementado grava um PUT por controle e oferece Desfazer', async () => {
    window.toggleSoASelection('c1', true);
    window.toggleSoASelection('c2', true);
    await window.batchMarkImplemented();

    expect(apiMock).toHaveBeenCalledWith('PUT', '/api/v1/controls/c1', { status: 'Implemented' });
    expect(apiMock).toHaveBeenCalledWith('PUT', '/api/v1/controls/c2', { status: 'Implemented' });
    expect(ultimoToast()).toContain('2 controles marcados');
    expect(document.querySelector('.toast-undo')).not.toBeNull();
  });

  it('Desfazer devolve CADA controle ao status que tinha, não a um padrão', async () => {
    window.toggleSoASelection('c1', true);
    window.toggleSoASelection('c2', true);
    await window.batchMarkImplemented();
    apiMock.mockClear();

    document.querySelector('.toast-undo').click();
    await new Promise(r => setTimeout(r, 0));

    expect(apiMock).toHaveBeenCalledWith('PUT', '/api/v1/controls/c1', { status: 'Missing' });
    expect(apiMock).toHaveBeenCalledWith('PUT', '/api/v1/controls/c2', { status: 'Partial' });
  });

  it('controle N/A é ignorado no lote: está fora do escopo', async () => {
    window.toggleSoASelection('c3', true);
    await window.batchMarkImplemented();
    expect(apiMock).not.toHaveBeenCalled();
    expect(ultimoToast()).toContain('fora do escopo');
  });

  it('a seleção limpa desmonta a barra e desmarca as caixas', () => {
    document.body.insertAdjacentHTML('beforeend', '<input type="checkbox" class="soa-check" checked>');
    window.toggleSoASelection('c1', true);
    window.clearSoASelection();
    expect(document.getElementById('soa-batch-bar')).toBeNull();
    expect(document.querySelector('.soa-check').checked).toBe(false);
  });
});
