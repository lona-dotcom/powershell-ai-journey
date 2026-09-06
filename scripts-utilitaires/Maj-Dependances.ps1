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
