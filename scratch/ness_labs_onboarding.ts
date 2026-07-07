import { calculatePricing } from './src/services/pricing';

const nessLabsAnswers = {
  empresa: 'ness. labs',
  headcount: 25,
  motivador: 'Vantagem Competitiva',
  infraestrutura: 'Nuvem Pública 100% (AWS/Azure/GCP)',
  arquitetura: 'Microsserviços / Cloud Native',
  criptografia: 'Criptografia Central (KMS) e TLS',
  repositorio: 'Git Moderno (GitHub/GitLab)',
  deploy: 'CI/CD Automatizado',
  seguranca_codigo: 'Review Rigoroso + Automação (SAST)',
  recursos_humanos: 'Treinamento Contínuo e Background Check',
  gestao_identidade: 'SSO e MFA Centralizado',
  continuidade: 'Backups Imutáveis Testados + Vendor Risk',
  iam_platform: 'Google Workspace / Okta',
  controles_implementados: 'Criptografia, Backup, MFA, SSO',
  stack: 'TypeScript, Node.js, Cloudflare Workers'
};

const result = calculatePricing(nessLabsAnswers);

console.log('--- DIAGNÓSTICO NESS. LABS ---');
console.log(`Tier: ${result.tier.name}`);
console.log(`Score: ${result.score}/${result.scoreMax}`);
console.log(`Preço Final: R$ ${result.precoFinal.toLocaleString('pt-BR')}`);
console.log(`Esforço: ${result.tier.pdNess} PD`);
console.log('Gaps Identificados:', result.gaps.map(g => g.titulo));
