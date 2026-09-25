$villes = @("Toamasina", "Antananarivo", "Paris", "Berlin", "New York", "Tokyo", "Sydney")
Write-Output "Nous avons $($villes.Length) villes dans notre tableau."
Write-Output "Voici la première et la dernière ville : $($villes[0]) et $($villes[-1])"
$numero = 1
foreach ($ville in $villes){
    Write-Output "La ville numero $numero est: $ville"
    $numero++
}