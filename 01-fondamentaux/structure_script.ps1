#Requires -Version 5.1
<#
.SYNOPSIS
    Compte les fichiers par extension dans un dossier donné.
.DESCRIPTION
    Parcourt un dossier et affiche le nombre de fichiers pour chaque extension trouvée.
.PARAMETER Chemin
    Le dossier à analyser. Par défaut: le dossier courant.
.EXAMPLE
    .\Compte-Extensions.ps1 -chemin "c:\Users\Alex\Documents"
#>

param(
    [string]$chemin = "."
)
# --- Verification basique avant de commencer ---
if (-not (Test-Path $chemin)) {
    Write-Error "Le chemin $chemin n'existe pas."
    exit 1
}

# --- Traitement principal ---
try {
    $fichiers = Get-ChildItem -Path $chemin -File -Recurse -ErrorAction Stop
    $parExtension = $fichiers | Group-Object Extension | Sort-Object Count -Descending
    foreach ($groupe in $parExtension) {
        Write-Output "$($groupe.Name) -> $($groupe.Count) fichier(s)"
    } 
}
catch {
    Write-Error "Erreur pendant l'analyse: $_"
}