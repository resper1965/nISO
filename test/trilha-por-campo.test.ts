// Trilha por campo: `campo: antes → depois`, agrupamento de lote pelo
// operation_id, e o desfazer que NÃO apaga linha.
import { describe, it, expect } from 'vitest';
import {
  ACAO_DESFEITA,
  apenasMudancas,
  colapsaDesfeitas,
  valorParaTrilha,
} from '../src/trilha-campo';

describe('regra: null de CMMI vira —, nunca a palavra "null"', () => {
  it('vazio, null e undefined viram o travessão', () => {
    expect(valorParaTrilha(null)).toBe('—');
    expect(valorParaTrilha(undefined)).toBe('—');
    expect(valorParaTrilha('')).toBe('—');
  });

  it('zero é um valor, não um vazio: CMMI 0 existe', () => {
    expect(valorParaTrilha(0)).toBe('0');
  });

  it('o resto vira texto', () => {
    expect(valorParaTrilha('Implementado')).toBe('Implementado');
    expect(valorParaTrilha(3)).toBe('3');
  });
});

describe('regra: só o campo que mudou entra na trilha', () => {
  it('campo com o mesmo valor não vira entrada', () => {
    const mudou = apenasMudancas([
      { campo: 'Status', antes: 'Missing', depois: 'Missing' },
      { campo: 'Maturidade CMMI', antes: 1, depois: 3 },
    ]);
    expect(mudou.map(m => m.campo)).toEqual(['Maturidade CMMI']);
  });

  it('null → vazio não é mudança: os dois renderizam o mesmo travessão', () => {
    expect(apenasMudancas([{ campo: 'Responsável', antes: null, depois: '' }])).toEqual([]);
  });

  it('preencher um campo vazio É mudança', () => {
    expect(apenasMudancas([{ campo: 'Responsável', antes: null, depois: 'Ana' }])).toHaveLength(1);
  });

  it('zero para null é mudança — CMMI 0 não é CMMI ausente', () => {
    expect(apenasMudancas([{ campo: 'Maturidade CMMI', antes: 0, depois: null }])).toHaveLength(1);
  });
});

describe('regra: desfazer esconde a operação da leitura, sem apagar linha', () => {
  const linhas = [
    { acao: 'control.updated', operacao: 'op-1', campo: 'Status' },
    { acao: 'control.updated', operacao: 'op-1', campo: 'Maturidade CMMI' },
    { acao: 'control.updated', operacao: 'op-2', campo: 'Status' },
  ];

  it('sem desfazer, tudo aparece', () => {
    expect(colapsaDesfeitas(linhas)).toHaveLength(3);
  });

  it('a operação desfeita some da leitura, e o registro do desfazer também', () => {
    const comDesfazer = [...linhas, { acao: ACAO_DESFEITA, operacao: 'op-1', campo: null }];
    const visiveis = colapsaDesfeitas(comDesfazer);
    // Um lote marcado e revertido dez segundos depois não é história: é ruído,
    // e ruído esconde as alterações que valem.
    expect(visiveis).toHaveLength(1);
    expect(visiveis[0].operacao).toBe('op-2');
  });

  it('desfazer uma operação não derruba as outras', () => {
    const comDesfazer = [...linhas, { acao: ACAO_DESFEITA, operacao: 'op-2', campo: null }];
    expect(colapsaDesfeitas(comDesfazer).map(l => l.operacao)).toEqual(['op-1', 'op-1']);
  });

  it('desfazer sem operação não esconde nada — não daria para saber o quê', () => {
    const solto = [...linhas, { acao: ACAO_DESFEITA, operacao: null, campo: null }];
    expect(colapsaDesfeitas(solto)).toHaveLength(3);
  });

  it('linha sem operação nunca é escondida', () => {
    const avulsa = [
      { acao: 'control.updated', operacao: null, campo: 'Status' },
      { acao: ACAO_DESFEITA, operacao: 'op-1', campo: null },
    ];
    expect(colapsaDesfeitas(avulsa)).toHaveLength(1);
  });
});
