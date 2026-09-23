$fromage = @{
    nom = "Camembert"
    prix = 5.99
    stock = 20
}
$yaourt = @{
    nom = "Yaourt nature"
    prix = 1.49
    stock = 50
}
$spaghetti = @{
    nom = "Spaghetti"
    prix = 2.99
    stock = 100
}
Write-Output "Pour le produit $($fromage.nom), le stock est de $($fromage.stock*$fromage.prix)euros. Pour le produit $($yaourt.nom), le stock est de $($yaourt.stock*$yaourt.prix)euros. Pour le produit $($spaghetti.nom), le stock est de $($spaghetti.stock*$spaghetti.prix)euros."