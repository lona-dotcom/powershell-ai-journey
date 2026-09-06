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
