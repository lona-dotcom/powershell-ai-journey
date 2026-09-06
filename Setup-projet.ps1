# ============================================================
# Setup-Projet.ps1
# Script d'installation automatisée pour PowerShell + Python + IA
# ============================================================

# Configuration des couleurs
$Cyan = "Cyan"
$Green = "Green"
$Yellow = "Yellow"
$Red = "Red"
$Magenta = "Magenta"

Write-Host @"
╔══════════════════════════════════════════════════════════════╗
║                                                              ║
║   🚀  PowerShell + Python + AI  -  Installation complète    ║
║                                                              ║
║   Ce script va configurer automatiquement votre projet       ║
║                                                              ║
╚══════════════════════════════════════════════════════════════╝
"@ -ForegroundColor $Magenta

# ============================================================
# ÉTAPE 1 : VÉRIFICATION DES PRÉREQUIS
# ============================================================
Write-Host "`n📋 ÉTAPE 1 : Vérification des prérequis..." -ForegroundColor $Cyan

# Vérifier PowerShell 7+
$psVersion = $PSVersionTable.PSVersion
if ($psVersion.Major -lt 7) {
    Write-Host "❌ PowerShell 7+ requis (version actuelle : $psVersion)" -ForegroundColor $Red
    Write-Host "📥 Téléchargez PowerShell 7 : https://github.com/PowerShell/PowerShell/releases" -ForegroundColor $Yellow
    exit 1
}
Write-Host "✅ PowerShell $psVersion" -ForegroundColor $Green

# Vérifier Python
try {
    $pythonVersion = python --version 2>&1
    if ($pythonVersion -match "Python (\d+\.\d+\.\d+)") {
        $pyVer = [version]$Matches[1]
        if ($pyVer.Major -lt 3 -or ($pyVer.Major -eq 3 -and $pyVer.Minor -lt 12)) {
            Write-Host "⚠️  Python 3.12+ recommandé (version : $pyVer)" -ForegroundColor $Yellow
        } else {
            Write-Host "✅ Python $pyVer" -ForegroundColor $Green
        }
    }
} catch {
    Write-Host "❌ Python n'est pas installé ou n'est pas dans le PATH" -ForegroundColor $Red
    Write-Host "📥 Téléchargez Python : https://python.org/downloads" -ForegroundColor $Yellow
    exit 1
}

# Vérifier Git
try {
    $gitVersion = git --version 2>&1
    if ($gitVersion -match "git version") {
        Write-Host "✅ $gitVersion" -ForegroundColor $Green
    }
} catch {
    Write-Host "⚠️  Git n'est pas installé (optionnel pour le versioning)" -ForegroundColor $Yellow
}

Write-Host "✅ Tous les prérequis sont vérifiés !" -ForegroundColor $Green

# ============================================================
# ÉTAPE 2 : CRÉATION DE L'ENVIRONNEMENT VIRTUEL PYTHON
# ============================================================
Write-Host "`n📦 ÉTAPE 2 : Création de l'environnement virtuel Python..." -ForegroundColor $Cyan

if (Test-Path ".venv") {
    Write-Host "⚠️  Environnement virtuel existant détecté" -ForegroundColor $Yellow
    $choice = Read-Host "Voulez-vous le recréer ? (o/N)"
    if ($choice -eq "o" -or $choice -eq "O") {
        Remove-Item -Path ".venv" -Recurse -Force
        python -m venv .venv
        Write-Host "✅ Environnement virtuel recréé" -ForegroundColor $Green
    } else {
        Write-Host "✅ Conservation de l'environnement existant" -ForegroundColor $Green
    }
} else {
    python -m venv .venv
    Write-Host "✅ Environnement virtuel créé" -ForegroundColor $Green
}

# ============================================================
# ÉTAPE 3 : ACTIVATION ET INSTALLATION DES DÉPENDANCES
# ============================================================
Write-Host "`n📦 ÉTAPE 3 : Installation des dépendances Python..." -ForegroundColor $Cyan

# Déterminer le chemin d'activation
if ($IsWindows) {
    $activateScript = ".\.venv\Scripts\Activate.ps1"
} else {
    $activateScript = ". .venv/bin/activate"
}

# Fonction pour exécuter dans l'environnement virtuel
function Invoke-InVenv {
    param([string]$Command)
    if ($IsWindows) {
        & ".venv\Scripts\python.exe" -c "$Command"
    } else {
        & ".venv/bin/python" -c "$Command"
    }
}

# Installer pip
Write-Host "⬆️  Mise à jour de pip..." -ForegroundColor $Yellow
Invoke-InVenv "import subprocess; subprocess.run(['pip', 'install', '--upgrade', 'pip'], check=True)"

# Installer les dépendances
Write-Host "📦 Installation des dépendances..." -ForegroundColor $Yellow
$requirements = @"
python-dotenv>=1.0.0
openai>=1.0.0
anthropic>=0.7.0
huggingface-hub>=0.20.0
google-generativeai>=0.3.0
pandas>=2.0.0
numpy>=1.24.0
scikit-learn>=1.3.0
matplotlib>=3.7.0
pymongo>=4.5.0
psycopg2-binary>=2.9.0
sqlalchemy>=2.0.0
requests>=2.31.0
aiohttp>=3.9.0
typing-extensions>=4.5.0
pydantic>=2.0.0
pytest>=7.4.0
black>=23.0.0
flake8>=6.0.0
"@

$requirements | Out-File -FilePath "requirements.txt" -Encoding utf8 -Force
Invoke-InVenv "import subprocess; subprocess.run(['pip', 'install', '-r', 'requirements.txt'], check=True)"

Write-Host "✅ Dépendances installées !" -ForegroundColor $Green

# ============================================================
# ÉTAPE 4 : CRÉATION DE LA STRUCTURE DE DOSSIERS
# ============================================================
Write-Host "`n📁 ÉTAPE 4 : Création de la structure de dossiers..." -ForegroundColor $Cyan

$dossiers = @(
    "01-fondamentaux",
    "02-avancees",
    "03-ia-integration",
    "04-projets-experts",
    "scripts-utilitaires",
    "library",
    "data",
    "docs",
    "corrections"
)

foreach ($dossier in $dossiers) {
    if (-not (Test-Path $dossier)) {
        New-Item -Path $dossier -ItemType Directory -Force | Out-Null
        Write-Host "  📁 Créé : $dossier/" -ForegroundColor $Green
    } else {
        Write-Host "  📁 Existe : $dossier/" -ForegroundColor $Gray
    }
}

# ============================================================
# ÉTAPE 5 : CRÉATION DES FICHIERS DE CONFIGURATION
# ============================================================
Write-Host "`n⚙️  ÉTAPE 5 : Création des fichiers de configuration..." -ForegroundColor $Cyan

# 5.1 : Créer .env
if (-not (Test-Path ".env")) {
    $envContent = @"
# ============================================================
# CONFIGURATION DU PROJET POWERSHELL + PYTHON + IA
# ============================================================

# ===== INTELLIGENCE ARTIFICIELLE =====
# Obtenez vos clés API sur :
# OpenAI : https://platform.openai.com/api-keys
# Anthropic : https://console.anthropic.com/account/keys
# Hugging Face : https://huggingface.co/settings/tokens
# Google AI : https://makersuite.google.com/app/apikey

OPENAI_API_KEY=
ANTHROPIC_API_KEY=
HUGGINGFACE_API_KEY=
GOOGLE_AI_API_KEY=

# ===== MODÈLES ET PARAMÈTRES =====
MODEL_NAME=gpt-4-turbo
TEMPERATURE=0.7
MAX_TOKENS=4096

# ===== BASES DE DONNÉES =====
MONGODB_URI=mongodb://localhost:27017/ai_journey
POSTGRES_HOST=localhost
POSTGRES_PORT=5432
POSTGRES_USER=admin
POSTGRES_PASSWORD=
POSTGRES_DB=ai_journey

# ===== STOCKAGE CLOUD =====
AZURE_STORAGE_CONNECTION_STRING=
AWS_ACCESS_KEY_ID=
AWS_SECRET_ACCESS_KEY=
S3_BUCKET_NAME=ai-journey-data

# ===== CONFIGURATION PROJET =====
PROJECT_ENV=development
LOG_LEVEL=INFO
"@
    $envContent | Out-File -FilePath ".env" -Encoding utf8 -Force
    Write-Host "✅ .env créé" -ForegroundColor $Green
    Write-Host "⚠️  N'oubliez pas de remplir vos clés API dans .env !" -ForegroundColor $Red
} else {
    Write-Host "✅ .env existe déjà" -ForegroundColor $Green
}

# 5.2 : Créer .env.example
$envExample = @"
# ============================================================
# CONFIGURATION DU PROJET (EXEMPLE)
# ============================================================

# INTELLIGENCE ARTIFICIELLE
OPENAI_API_KEY=sk-proj-votre_cle_api_ici
ANTHROPIC_API_KEY=sk-ant-votre_cle_api_ici
HUGGINGFACE_API_KEY=hf_votre_cle_api_ici
GOOGLE_AI_API_KEY=AIzaSy-votre_cle_api_ici

# MODÈLES
MODEL_NAME=gpt-4-turbo
TEMPERATURE=0.7
MAX_TOKENS=4096

# BASES DE DONNÉES
MONGODB_URI=mongodb://localhost:27017/ai_journey
POSTGRES_HOST=localhost
POSTGRES_PORT=5432
POSTGRES_USER=admin
POSTGRES_PASSWORD=super_secure_password
POSTGRES_DB=ai_journey

# STOCKAGE CLOUD
AZURE_STORAGE_CONNECTION_STRING=DefaultEndpointsProtocol=...
AWS_ACCESS_KEY_ID=AKIAXXXXXXXXXXXXXX
AWS_SECRET_ACCESS_KEY=xxxxxxxxxxxxxxxx
S3_BUCKET_NAME=ai-journey-data

# PROJET
PROJECT_ENV=development
LOG_LEVEL=INFO
"@
$envExample | Out-File -FilePath ".env.example" -Encoding utf8 -Force
Write-Host "✅ .env.example créé" -ForegroundColor $Green

# 5.3 : Créer config.py dans library/
$configPython = @"
# library/config.py
import os
from pathlib import Path
from dotenv import load_dotenv

# Charger .env
BASE_DIR = Path(__file__).parent.parent
ENV_FILE = BASE_DIR / '.env'
load_dotenv(ENV_FILE)

class Config:
    \"\"\"Configuration centralisée du projet\"\"\"
    
    # === IA ===
    OPENAI_API_KEY = os.getenv('OPENAI_API_KEY')
    ANTHROPIC_API_KEY = os.getenv('ANTHROPIC_API_KEY')
    HUGGINGFACE_API_KEY = os.getenv('HUGGINGFACE_API_KEY')
    GOOGLE_AI_API_KEY = os.getenv('GOOGLE_AI_API_KEY')
    
    # === MODÈLES ===
    MODEL_NAME = os.getenv('MODEL_NAME', 'gpt-4-turbo')
    TEMPERATURE = float(os.getenv('TEMPERATURE', 0.7))
    MAX_TOKENS = int(os.getenv('MAX_TOKENS', 4096))
    
    # === BASE DE DONNÉES ===
    MONGODB_URI = os.getenv('MONGODB_URI')
    POSTGRES_HOST = os.getenv('POSTGRES_HOST', 'localhost')
    POSTGRES_PORT = int(os.getenv('POSTGRES_PORT', 5432))
    POSTGRES_USER = os.getenv('POSTGRES_USER', 'admin')
    POSTGRES_PASSWORD = os.getenv('POSTGRES_PASSWORD')
    POSTGRES_DB = os.getenv('POSTGRES_DB', 'ai_journey')
    
    # === STOCKAGE ===
    AZURE_STORAGE_CONNECTION_STRING = os.getenv('AZURE_STORAGE_CONNECTION_STRING')
    AWS_ACCESS_KEY_ID = os.getenv('AWS_ACCESS_KEY_ID')
    AWS_SECRET_ACCESS_KEY = os.getenv('AWS_SECRET_ACCESS_KEY')
    S3_BUCKET_NAME = os.getenv('S3_BUCKET_NAME', 'ai-journey-data')
    
    # === PROJET ===
    PROJECT_ENV = os.getenv('PROJECT_ENV', 'development')
    LOG_LEVEL = os.getenv('LOG_LEVEL', 'INFO')
    
    @classmethod
    def validate(cls):
        \"\"\"Vérifier que les clés essentielles sont présentes\"\"\"
        required = ['OPENAI_API_KEY']
        missing = [key for key in required if not getattr(cls, key)]
        if missing:
            print(f"❌ Variables manquantes : {missing}")
            return False
        print("✅ Configuration validée !")
        return True
    
    @classmethod
    def summary(cls):
        \"\"\"Afficher un résumé de la configuration\"\"\"
        print("="*50)
        print("📋 CONFIGURATION DU PROJET")
        print("="*50)
        print(f"🔹 Environnement : {cls.PROJECT_ENV}")
        print(f"🔹 Modèle IA : {cls.MODEL_NAME}")
        print(f"🔹 Température : {cls.TEMPERATURE}")
        print(f"🔹 Max tokens : {cls.MAX_TOKENS}")
        print(f"🔹 Log level : {cls.LOG_LEVEL}")
        print(f"🔹 OpenAI : {'✅' if cls.OPENAI_API_KEY else '❌'}")
        print(f"🔹 Anthropic : {'✅' if cls.ANTHROPIC_API_KEY else '❌'}")
        print("="*50)

config = Config()

if __name__ == "__main__":
    Config.summary()
    Config.validate()
"@
$configPython | Out-File -FilePath "library\config.py" -Encoding utf8 -Force
Write-Host "✅ library/config.py créé" -ForegroundColor $Green

# 5.4 : Créer __init__.py dans library
New-Item -Path "library\__init__.py" -ItemType File -Force | Out-Null
Write-Host "✅ library/__init__.py créé" -ForegroundColor $Green

# ============================================================
# ÉTAPE 6 : CRÉATION DU .gitignore
# ============================================================
Write-Host "`n🔒 ÉTAPE 6 : Configuration de .gitignore..." -ForegroundColor $Cyan

if (-not (Test-Path ".gitignore")) {
    $gitignore = @"
# ===== VARIABLES D'ENVIRONNEMENT =====
.env
.env.*
*.env
*.env.local

# ===== PYTHON =====
__pycache__/
*.pyc
*.pyo
*.pyd
.Python
.venv/
venv/
env/
ENV/
env.bak/
venv.bak/
*.egg-info/
dist/
build/
*.whl
*.egg

# ===== POWER SHELL =====
*.ps1.bak
*.psm1.bak
*.psd1.bak
*.ps1xml

# ===== IDÉ ET ÉDITEURS =====
.vscode/
.idea/
*.swp
*.swo
*~
.DS_Store
Thumbs.db

# ===== DONNÉES =====
data/*.csv
data/*.json
data/*.db
data/*.sqlite
!data/.gitkeep
logs/
*.log

# ===== FICHIERS SENSIBLES =====
*.key
*.pem
*.crt
*.p12
*.pfx
*.secret
config.local.ini
credentials.json

# ===== DÉPENDANCES =====
node_modules/
jspm_packages/

# ===== DIVERS =====
*.tmp
*.temp
*.bak
*.backup
*.old
"@
    $gitignore | Out-File -FilePath ".gitignore" -Encoding utf8 -Force
    Write-Host "✅ .gitignore créé" -ForegroundColor $Green
} else {
    Write-Host "✅ .gitignore existe déjà" -ForegroundColor $Green
}

