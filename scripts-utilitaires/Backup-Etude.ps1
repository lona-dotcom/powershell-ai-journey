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
