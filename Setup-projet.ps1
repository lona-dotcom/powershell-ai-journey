<#
.SYNOPSIS
    Setup-Projet.ps1 - Initialise l'environnement complet pour la roadmap PowerShell + IA

.DESCRIPTION
    Ce script cree toute la structure de dossiers, les fichiers de configuration,
    et prepare l'environnement pour suivre la roadmap PowerShell augmentee par l'IA.

.PARAMETER Chemin
    Chemin d'installation du projet (par defaut : ~/Documents/GitHub/powershell-ai-journey)

.PARAMETER ApiKey
    Cle API OpenAI (optionnelle, sera demandee si non fournie)

.PARAMETER NoGit
    Desactive l'initialisation du depot Git

.EXAMPLE
    .\Setup-Projet.ps1
    Cree le projet dans le dossier par defaut

.EXAMPLE
    .\Setup-Projet.ps1 -Chemin "C:\Dev\PowerShellIA" -ApiKey "sk-xxxxx"
    Cree le projet dans un dossier specifique avec la cle API
#>

[CmdletBinding()]
param(
    [Parameter()]
    [string]$Chemin = "$env:USERPROFILE\Documents\GitHub\powershell-ai-journey",
    
    [Parameter()]
    [string]$ApiKey,
    
    [Parameter()]
    [switch]$NoGit
)
# =============================================
# 1. VERIFICATION DES PRE-REQUIS
# =============================================
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  ROUGE SETUP DU PROJET POWERSHELL + IA" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$psVersion = $PSVersionTable.PSVersion
if ($psVersion.Major -lt 7) {
    Write-Host "ERREUR PowerShell 7+ est requis (version actuelle: $psVersion)" -ForegroundColor Red
    Write-Host "Telechargez PowerShell 7 : https://github.com/PowerShell/PowerShell" -ForegroundColor Yellow
    exit 1
}
Write-Host "OK PowerShell $psVersion detecte" -ForegroundColor Green

if (!$NoGit) {
    $gitPath = Get-Command git -ErrorAction SilentlyContinue
    if ($gitPath) {
        Write-Host "OK Git detecte : $($gitPath.Source)" -ForegroundColor Green
    } else {
        Write-Host "ATTENTION Git non trouve - l'initialisation du depot sera ignoree" -ForegroundColor Yellow
        Write-Host "Installez Git : https://git-scm.com/download/win" -ForegroundColor Yellow
        $NoGit = $true
    }
}

$vscodePath = Get-Command code -ErrorAction SilentlyContinue
if ($vscodePath) {
    Write-Host "OK VS Code detecte" -ForegroundColor Green
} else {
    Write-Host "INFO VS Code recommande : https://code.visualstudio.com/" -ForegroundColor Yellow
}

# =============================================
# 2. CREATION DE LA STRUCTURE
# =============================================
Write-Host "`nCreation de la structure du projet..." -ForegroundColor Yellow

$structure = @(
    "$Chemin\01-fondamentaux\cours",
    "$Chemin\01-fondamentaux\projets",
    "$Chemin\02-avancees\cours",
    "$Chemin\02-avancees\projets",
    "$Chemin\03-ia-integration\cours",
    "$Chemin\03-ia-integration\projets",
    "$Chemin\03-ia-integration\projets\AssistantScript\prompts",
    "$Chemin\04-projets-experts",
    "$Chemin\corrections",
    "$Chemin\library\modules\MaBiblioPerso",
    "$Chemin\library\fonctions",
    "$Chemin\library\profiles",
    "$Chemin\library\templates",
    "$Chemin\data\logs",
    "$Chemin\data\exports",
    "$Chemin\data\samples",
    "$Chemin\docs",
    "$Chemin\scripts-utilitaires"
)

foreach ($dossier in $structure) {
    if (!(Test-Path $dossier)) {
        New-Item -Path $dossier -ItemType Directory -Force | Out-Null
        Write-Host "  DOSSIER $dossier" -ForegroundColor Gray
    }
}

Write-Host "OK Structure creee" -ForegroundColor Green
# =============================================
# 3. FICHIERS DE CONFIGURATION
# =============================================
Write-Host "`nGeneration des fichiers de configuration..." -ForegroundColor Yellow

# 3.1 .gitignore
$gitignoreContent = @'
# Cles API et secrets
*.key
*.pem
*.crt
*.pfx
.env
secrets.ps1
api_key.txt
config_securisee.ps1

# Dossiers de donnees
data/logs/
data/exports/
data/samples/
*.log
*.csv
*.json
*.xml

# Fichiers systeme
.DS_Store
Thumbs.db
desktop.ini

# PowerShell
*.psd1
*.psm1
*.ps1xml
*.psss

# Visual Studio Code
.vscode/
*.code-workspace

# Python
__pycache__/
*.pyc
*.pyo
venv/
.venv/

# Node
node_modules/
package-lock.json

# Archives
*.zip
*.rar
*.7z
*.gz
*.tar

# Fichiers temporaires
*.tmp
*.bak
*.swp
*.swo
~$*
'@
$gitignorePath = Join-Path $Chemin ".gitignore"
$gitignoreContent | Out-File -FilePath $gitignorePath -Encoding UTF8
Write-Host "  OK .gitignore" -ForegroundColor Gray

# 3.2 README.md
$readmeContent = @'
# PowerShell + IA - Roadmap Complete

Bienvenue sur mon depot d'etude dedie a la maitrise de PowerShell augmente par l'Intelligence Artificielle.

## Structure du depot

01-fondamentaux/ : Les bases : syntaxe, pipeline, premieres cmdlets
02-avancees/ : Fonctions, gestion d'erreurs, remoting, AD
03-ia-integration/ : API LLM, Prompt Engineering, PSAI, agents
04-projets-experts/ : Projets complexes : monitoring, parc, DevOps
corrections/ : Toutes les solutions des projets
library/ : Modules et fonctions reutilisables
data/ : Logs, exports, fichiers de test
docs/ : Documentation generale
scripts-utilitaires/ : Scripts d'automatisation du projet

## Pre-requis

- PowerShell 7.3+
- Visual Studio Code avec l'extension PowerShell
- Git
- Cle API OpenAI pour les projets IA

## Securite

Ne versionnez JAMAIS vos cles API ou secrets. Utilisez le fichier .env pour stocker ces informations en local.
'@
$readmePath = Join-Path $Chemin "README.md"
$readmeContent | Out-File -FilePath $readmePath -Encoding UTF8
Write-Host "  OK README.md" -ForegroundColor Gray

# 3.3 Fichier .env
$envContent = @"
# Fichier de configuration - NE PAS VERSIONNER
OPENAI_API_KEY="votre_cle_api_ici"
OPENAI_ORG_ID="votre_org_id_ici"
OPENAI_PROJECT_ID="votre_project_id_ici"
AZURE_SUBSCRIPTION_ID=""
AZURE_TENANT_ID=""
AZURE_CLIENT_ID=""
AZURE_CLIENT_SECRET=""
PROJECT_ROOT="$Chemin"
LOG_LEVEL="Info"
"@
$envPath = Join-Path $Chemin ".env"
$envContent | Out-File -FilePath $envPath -Encoding UTF8
Write-Host "  OK .env (template)" -ForegroundColor Gray
# 3.4 Script Nouveau-Projet.ps1
$nouveauProjetContent = @'
<#
.SYNOPSIS
    Nouveau-Projet.ps1 - Cree un nouveau projet

.PARAMETER Nom
    Nom du projet

.PARAMETER Etape
    Etape cible (fondamentaux, avancees, ia-integration, projets-experts)
#>

param(
    [Parameter(Mandatory)]
    [string]$Nom,
    
    [Parameter(Mandatory)]
    [ValidateSet("fondamentaux", "avancees", "ia-integration", "projets-experts")]
    [string]$Etape
)

$basePath = Split-Path $PSScriptRoot
$etapeNum = @{
    "fondamentaux" = "01-fondamentaux"
    "avancees" = "02-avancees"
    "ia-integration" = "03-ia-integration"
    "projets-experts" = "04-projets-experts"
}

$projetPath = Join-Path $basePath "$($etapeNum[$Etape])\projets\$Nom"

if (Test-Path $projetPath) {
    Write-Error "Le projet $Nom existe deja !"
    exit 1
}

New-Item -Path $projetPath -ItemType Directory -Force | Out-Null
New-Item -Path "$projetPath\src" -ItemType Directory -Force | Out-Null
New-Item -Path "$projetPath\tests" -ItemType Directory -Force | Out-Null
New-Item -Path "$projetPath\docs" -ItemType Directory -Force | Out-Null

Write-Host "OK Projet $Nom cree dans $projetPath" -ForegroundColor Green
'@
$nouveauProjetPath = Join-Path $Chemin "scripts-utilitaires\Nouveau-Projet.ps1"
$nouveauProjetContent | Out-File -FilePath $nouveauProjetPath -Encoding UTF8
Write-Host "  OK scripts-utilitaires\Nouveau-Projet.ps1" -ForegroundColor Gray

# 3.5 Script Maj-Dependances.ps1
$majDependancesContent = @'
<#
.SYNOPSIS
    Maj-Dependances.ps1 - Installe les modules necessaires
#>

param([switch]$Force)

Write-Host "Installation des dependances..." -ForegroundColor Yellow

$modules = @(
    @{Name = "PSAI"; Description = "Framework IA"},
    @{Name = "PowerShellGet"; Description = "Gestionnaire"},
    @{Name = "Pester"; Description = "Tests"}
)

foreach ($module in $modules) {
    $existing = Get-Module -Name $module.Name -ListAvailable -ErrorAction SilentlyContinue
    if ($existing -and !$Force) {
        Write-Host "OK $($module.Name) : deja installe" -ForegroundColor Green
    } else {
        Write-Host "Installation de $($module.Name)..." -ForegroundColor Yellow
        try {
            Install-Module -Name $module.Name -Scope CurrentUser -Force -AllowClobber -ErrorAction Stop
            Write-Host "OK $($module.Name) installe" -ForegroundColor Green
        }
        catch {
            Write-Host "ERREUR : $($_.Exception.Message)" -ForegroundColor Red
        }
    }
}
'@
$majDependancesPath = Join-Path $Chemin "scripts-utilitaires\Maj-Dependances.ps1"
$majDependancesContent | Out-File -FilePath $majDependancesPath -Encoding UTF8
Write-Host "  OK scripts-utilitaires\Maj-Dependances.ps1" -ForegroundColor Gray

# 3.6 Script Backup-Etude.ps1
$backupContent = @'
<#
.SYNOPSIS
    Backup-Etude.ps1 - Sauvegarde complete du projet
#>

param([string]$Destination = "$env:USERPROFILE\Backups\powershell-ia-roadmap")

$date = Get-Date -Format "yyyy-MM-dd_HH-mm"
$backupPath = "$Destination\_backup_$date"

if (!(Test-Path $Destination)) {
    New-Item -Path $Destination -ItemType Directory -Force | Out-Null
}

$sourcePath = Split-Path $PSScriptRoot
try {
    Compress-Archive -Path "$sourcePath\*" -DestinationPath "$backupPath.zip" -ErrorAction Stop
    Write-Host "OK Sauvegarde reussie : $backupPath.zip" -ForegroundColor Green
}
catch {
    Write-Host "ERREUR : $($_.Exception.Message)" -ForegroundColor Red
}
'@
$backupPathScript = Join-Path $Chemin "scripts-utilitaires\Backup-Etude.ps1"
$backupContent | Out-File -FilePath $backupPathScript -Encoding UTF8
Write-Host "  OK scripts-utilitaires\Backup-Etude.ps1" -ForegroundColor Gray

# =============================================
# 4. FINALISATION
# =============================================
Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "  OK PROJET INSTALLE AVEC SUCCES !" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Projet installe dans : $Chemin" -ForegroundColor White
Write-Host ""
Write-Host "PROCHAINES ETAPES :" -ForegroundColor Yellow
Write-Host "  1. Ouvrez VS Code : code $Chemin" -ForegroundColor White
Write-Host "  2. Activez votre profil" -ForegroundColor White
Write-Host "  3. Commencez les cours !" -ForegroundColor White
Write-Host ""

Start-Process "explorer.exe" $Chemin
