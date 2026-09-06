# scripts-utilitaires/organiser-fichiers.ps1 (VERSION FINALE SÉCURISÉE)
param(
    [string]$DossierSource = ".",
    [switch]$Force
)

# ⭐ LISTE DES DOSSIERS PROTÉGÉS (NE JAMAIS DÉPLACER)
$dossiersProteges = @(
    ".venv", "venv", ".git", ".vscode", ".idea",
    "__pycache__", "node_modules", ".jupyter",
    ".ipynb_checkpoints", "docs", "data", "library"
)

# ⭐ LISTE DES FICHIERS PROTÉGÉS
$fichiersProteges = @(
    "organiser-fichiers.ps1", "organiser_fichiers.py",
    "Setup-Projet.ps1", "Corriger-Structure.ps1",
    ".gitignore", ".env", ".env.example",
    "README.md", "requirements.txt",
    "config.py", "__init__.py"
)

Write-Host @"
╔══════════════════════════════════════════════════════════════╗
║   🛡️  ORGANISATION PROTÉGÉE DES FICHIERS                     ║
║                                                              ║
║   Dossiers protégés : .venv, .git, .vscode, .jupyter       ║
║   Fichiers protégés : config.py, __init__.py, .env         ║
╚══════════════════════════════════════════════════════════════╝
"@ -ForegroundColor Cyan

# Règles de classification
$regles = @{
    "\.ps1$" = "scripts-utilitaires"
    "\.py$" = "scripts-utilitaires"
    "\.csv$" = "data"
    "\.json$" = "data"
    "\.xml$" = "data"
    "\.txt$" = "data"
    "\.md$" = "docs"
    "\.pdf$" = "docs"
    "\.ipynb$" = "03-ia-integration"
}

$compteur = 0

# Parcourir les fichiers à la racine
Get-ChildItem -Path $DossierSource -File | ForEach-Object {
    $nom = $_.Name
    $cheminComplet = $_.FullName
    
    # IGNORER les fichiers protégés
    if ($fichiersProteges -contains $nom) {
        Write-Host "⏭️ Fichier protégé : $nom" -ForegroundColor Yellow
        return
    }
    
    # Vérifier si le dossier parent est protégé
    $parent = $_.Directory.Name
    if ($dossiersProteges -contains $parent) {
        Write-Host "⏭️ Fichier dans dossier protégé : $nom" -ForegroundColor Yellow
        return
    }
    
    # Appliquer les règles
    $deplace = $false
    foreach ($regle in $regles.Keys) {
        if ($nom -match $regle) {
            $destination = $regles[$regle]
            $cheminDest = Join-Path -Path $DossierSource -ChildPath $destination
            
            # Créer le dossier si nécessaire
            if (-not (Test-Path $cheminDest)) {
                New-Item -Path $cheminDest -ItemType Directory -Force | Out-Null
            }
            
            # Déplacer le fichier
            Move-Item -Path $cheminComplet -Destination $cheminDest -Force
            Write-Host "📁 $nom → $destination/" -ForegroundColor Green
            $compteur++
            $deplace = $true
            break
        }
    }
    
    if (-not $deplace) {
        Write-Host "ℹ️  Aucune règle pour : $nom" -ForegroundColor Gray
    }
}

Write-Host "`n✅ $compteur fichier(s) déplacé(s)" -ForegroundColor Cyan
Write-Host "🛡️  Dossiers protégés préservés : .venv, .git, .vscode, library, data" -ForegroundColor Yellow