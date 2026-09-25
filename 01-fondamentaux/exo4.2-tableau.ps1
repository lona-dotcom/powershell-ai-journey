$villes = @("Toamasina", "Antananarivo", "Paris", "Berlin")
$n = 1
foreach ($ville in $villes) {
    Write-Output "La Ville numero ${n}: $ville"
    $n++
}