$villes = @("Toamasina", "Antananarivo", "Paris", "Berlin", "New York", "Tokyo", "Sydney")
$n = 1
foreach ($ville in $villes) {
    Write-Output "La Ville numero ${n}: $ville"
    $n++
}