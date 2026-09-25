$nombres = 1..10

# 1. Somme de tous les éléments
$somme = ($nombres | Measure-Object -Sum).Sum
Write-Output "Somme : $somme"

# 2. Nombres pairs uniquement
$pairs = $nombres | Where-Object { $_ % 2 -eq 0 }
Write-Output "Nombres pairs : $($pairs -join ', ')"