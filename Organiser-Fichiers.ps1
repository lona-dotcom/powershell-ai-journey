# Organiser-Fichiers.ps1
# Script pour organiser automatiquement les fichiers par extension/contenu

param(
    [string]$DossierSource = "."
)

# Définir les règles de classification
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
    "\.env$" = "."  # Reste à la racine
    "\.gitignore$" = "."
}

# Parcourir tous les fichiers du dossier courant (sauf les dossiers existants)
Get-ChildItem -Path $DossierSource -File | ForEach-Object {
    $fichier = $_.Name
    $extension = $_.Extension
    $destination = $null
    
    # Vérifier si l'extension correspond à une règle
    foreach ($regle in $regles.Keys) {
        if ($fichier -match $regle) {
            $destination = $regles[$regle]
            break
        }
    }
    
    # Si une destination est trouvée et différente du dossier courant
    if ($destination -and $destination -ne ".") {
        $cheminDest = Join-Path -Path $DossierSource -ChildPath $destination
        
        # Créer le dossier s'il n'existe pas
        if (-not (Test-Path $cheminDest)) {
            New-Item -Path $cheminDest -ItemType Directory -Force | Out-Null
        }
        
        # Déplacer le fichier
        Move-Item -Path $_.FullName -Destination $cheminDest -Force
        Write-Host "📁 Déplacé : $fichier → $destination/" -ForegroundColor Green
    }
}

Write-Host "✅ Organisation terminée !" -ForegroundColor Cyan