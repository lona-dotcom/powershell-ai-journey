$villes = @("Toamasina", "Antananarivo", "Paris", "Berlin")
Write-Output "Nous avons $($villes.Length) villes dans notre tableau."
Write-Output "Voici la première et la dernière ville : $($villes[0]) et $($villes[-1])"