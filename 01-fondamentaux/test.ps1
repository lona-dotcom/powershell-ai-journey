$global:maGlobale = "je vis partout"
$script:maScript  = "je vis dans le script"

function Afficher {
    Write-Host "Globale : $global:maGlobale"
    Write-Host "Script  : $script:maScript"
}

Afficher