$prixHT = 100
$tauxTVA = 0.20
$prixTTC = $prixHT * (1 + $tauxTVA)
Write-Output "Le prix TTC est : $prixTTC"