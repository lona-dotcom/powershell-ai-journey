const fs = require('fs');
const MarkdownIt = require('markdown-it');
const puppeteer = require('puppeteer');

async function generatePDF() {
    const mdContent = fs.readFileSync('ai-agent-roadmap.md', 'utf8');
    const md = new MarkdownIt({ html: true, breaks: true });
    const htmlBody = md.render(mdContent);

    const htmlTemplate = `
    <!DOCTYPE html>
    <html lang="fr">
    <head>
        <meta charset="UTF-8">
        <title>Roadmap Ingrénierie Pédagogique & Agents IA</title>
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&family=JetBrains+Mono:wght@400;500&display=swap');

            :root {
                --primary: #6366f1;
                --primary-dark: #4f46e5;
                --accent: #06b6d4;
                --bg: #090d16;
                --card-bg: #111827;
                --text: #e2e8f0;
                --text-muted: #94a3b8;
                --border: #1e293b;
            }

            * {
                box-sizing: border-box;
                margin: 0;
                padding: 0;
            }

            body {
                font-family: 'Outfit', sans-serif;
                background-color: #ffffff;
                color: #1e293b;
                line-height: 1.6;
                padding: 0;
            }

            .cover-page {
                height: 100vh;
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
                background: linear-gradient(135deg, #0f172a 0%, #1e1b4b 100%);
                color: #ffffff;
                text-align: center;
                padding: 4rem;
                page-break-after: always;
                position: relative;
                overflow: hidden;
            }

            .cover-page::before {
                content: '';
                position: absolute;
                width: 600px;
                height: 600px;
                background: radial-gradient(circle, rgba(99, 102, 241, 0.15) 0%, rgba(0,0,0,0) 70%);
                top: -200px;
                right: -200px;
                border-radius: 50%;
            }

            .badge {
                background: rgba(99, 102, 241, 0.2);
                color: #818cf8;
                border: 1px solid rgba(99, 102, 241, 0.4);
                padding: 0.5rem 1.5rem;
                border-radius: 50px;
                font-size: 0.85rem;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 2px;
                margin-bottom: 2rem;
            }

            .cover-page h1 {
                font-size: 3rem;
                font-weight: 800;
                line-height: 1.2;
                margin-bottom: 1.5rem;
                background: linear-gradient(to right, #ffffff, #94a3b8);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
            }

            .cover-page p {
                font-size: 1.25rem;
                color: #94a3b8;
                max-width: 700px;
                margin-bottom: 3rem;
            }

            .cover-meta {
                display: flex;
                gap: 2rem;
                font-size: 0.95rem;
                color: #64748b;
                border-top: 1px solid rgba(255, 255, 255, 0.1);
                padding-top: 2rem;
            }

            .content-container {
                max-width: 1000px;
                margin: 0 auto;
                padding: 3rem 2rem;
            }

            h1, h2, h3 {
                color: #0f172a;
                font-weight: 700;
            }

            h1 {
                font-size: 2.25rem;
                border-bottom: 3px solid var(--primary);
                padding-bottom: 0.5rem;
                margin-top: 3rem;
                margin-bottom: 1.5rem;
                page-break-before: always;
            }

            h1:first-of-type {
                page-break-before: avoid;
            }

            h2 {
                font-size: 1.5rem;
                color: #334155;
                margin-top: 2rem;
                margin-bottom: 1rem;
            }

            h3 {
                font-size: 1.15rem;
                color: #475569;
                margin-top: 1.5rem;
                margin-bottom: 0.5rem;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            p {
                margin-bottom: 1rem;
                color: #334155;
            }

            ul {
                margin-bottom: 1.5rem;
                padding-left: 1.5rem;
            }

            li {
                margin-bottom: 0.5rem;
                color: #475569;
            }

            strong {
                color: #0f172a;
            }

            /* Phase specific styling via DOM structure */
            hr {
                border: none;
                height: 1px;
                background: #e2e8f0;
                margin: 2rem 0;
            }

            .page-break {
                page-break-after: always;
            }

            @page {
                size: A4;
                margin: 20mm;
                @bottom-right {
                    content: counter(page);
                    font-family: 'Outfit', sans-serif;
                    font-size: 9pt;
                    color: #94a3b8;
                }
                @bottom-left {
                    content: "Roadmap IA Agent - Masterclass";
                    font-family: 'Outfit', sans-serif;
                    font-size: 9pt;
                    color: #94a3b8;
                }
            }
        </style>
    </head>
    <body>
        <div class="cover-page">
            <div class="badge">Masterclass d'Ingénierie Pédagogique</div>
            <h1>ROADMAP D'APPRENTISSAGE<br>DÉVELOPPEMENT D'AGENTS IA</h1>
            <p>Le plan directeur ultime pour maîtriser la conception, l'orchestration, l'évaluation et l'optimisation des Agents Intelligents et Systèmes Multi-Agents de débutant à expert.</p>
            <div class="cover-meta">
                <span>🎯 Version 2026</span>
                <span>⚡ Approche Agentique & Pragmatique</span>
                <span>🚀 8 Phases Structurées</span>
            </div>
        </div>

        <div class="content-container">
            ${htmlBody}
        </div>
    </body>
    </html>
    `;

    fs.writeFileSync('roadmap-preview.html', htmlTemplate);

    const browser = await puppeteer.launch({ headless: true });
    const page = await browser.newPage();
    await page.setContent(htmlTemplate, { waitUntil: 'networkidle0' });

    await page.pdf({
        path: 'roadmap-agents-ia.pdf',
        format: 'A4',
        printBackground: true,
        margin: {
            top: '0mm',
            right: '0mm',
            bottom: '0mm',
            left: '0mm'
        }
    });

    await browser.close();
    console.log('PDF généré avec succès : roadmap-agents-ia.pdf');
}

generatePDF().catch(console.error);