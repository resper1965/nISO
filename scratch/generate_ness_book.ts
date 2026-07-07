import { PolicyGeneratorService } from '../src/services/policy-generator';
import * as fs from 'fs';
import * as path from 'path';

async function run() {
    const generator = new PolicyGeneratorService('c:/Users/resper/OneDrive/Área de Trabalho/DESENVOLVIMENTO/niso');
    const outputDir = 'c:/Users/resper/OneDrive/Área de Trabalho/DESENVOLVIMENTO/niso/deliveries/ness-labs';
    
    if (!fs.existsSync(outputDir)) {
        fs.mkdirSync(outputDir, { recursive: true });
    }

    const context = {
        organizationName: 'ness. labs',
        policyOwner: 'Ricardo Resper (CISO)',
        approver: 'Management Board',
        status: 'Approved' as const
    };

    const templates = await generator.listAvailableTemplates();
    
    console.log('--- GERANDO BOOK DOCUMENTAL: ness. labs ---');
    
    for (const template of templates) {
        try {
            const content = await generator.generate(template, context);
            const fileName = `${template}.md`;
            fs.writeFileSync(path.join(outputDir, fileName), content);
            console.log(`[OK] ${fileName} gerado com sucesso.`);
        } catch (e) {
            console.error(`[ERRO] Falha ao gerar ${template}:`, e);
        }
    }
    
    console.log('\nBook completo disponível em: deliveries/ness-labs/');
}

run();
