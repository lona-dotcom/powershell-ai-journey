$dossier = "C:\Users\User\Documents\GitHub\powershell-ai-journey\01-fondamentaux\MesScripts"

if (-Not (Test-Path -Path $dossier)) {
    New-Item -Path $dossier -ItemType Directory
}

Get-ChildItem -Path "$dossier\*.ps1" | Unblock-File