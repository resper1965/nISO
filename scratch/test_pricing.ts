import { calculatePricing } from '../src/services/pricing.ts';

const testAnswers = {
  empresa: 'Tech Corp Teste',
  headcount: '120', 
  infraestrutura: 'Nuvem Pública 100% (AWS/Azure/GCP)', 
  arquitetura: 'Microsserviços / Cloud Native', 
  gestao_identidade: 'SSO e MFA Centralizado', 
  controles_implementados: 'Backup, Criptografia, Firewall', 
  vulnerabilidades_conhecidas: '', 
};

const result = calculatePricing(testAnswers as any);

console.log('--- TESTE DE PRECIFICAÇÃO (ESFORÇO) ---');
console.log(`Empresa: ${testAnswers.empresa}`);
console.log(`Score: ${result.score} (${result.tier.name})`);
console.log(`Fator Escopo: ${result.scopeInfo.fator} (${result.scopeInfo.label})`);
console.log(`Preço Final: R$ ${result.precoFinal.toLocaleString('pt-BR')}`);
console.log(`Esforço Total (PDs): ${Math.round(result.eco.custoDireto / result.eco.taxaBlendada)} PDs`);
console.log(`Margem Operacional: ${(result.eco.margemPct * 100).toFixed(1)}%`);
console.log('--- BREAKDOWN DE FASES ---');
result.fases.forEach((f: any) => {
  console.log(`- ${f.nome}: R$ ${f.valorFase?.toLocaleString('pt-BR')} (${f.pdNess} PDs)`);
});
