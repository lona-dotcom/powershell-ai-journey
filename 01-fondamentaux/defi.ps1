# On crée UNE SEULE variable : un tableau (@()) qui contient plusieurs hashtables
# Chaque hashtable représente un produit avec ses propriétés nom/prix/stock
$produits = @(
    @{ nom = "Camembert"; prix = 5.99; stock = 20 }
    @{ nom = "Yaourt nature"; prix = 1.49; stock = 50 }
    @{ nom = "Spaghetti"; prix = 2.99; stock = 100 }
)

# On initialise un accumulateur à 0 : c'est lui qui va cumuler la valeur totale
$valeurTotaleStock = 0

# La boucle foreach parcourt chaque élément du tableau $produits, un par un
# A chaque tour, $produit contient temporairement la hashtable en cours
foreach ($produit in $produits) {
    # On calcule la valeur de CE produit (prix * quantité en stock)
    $valeurProduit = $produit.prix * $produit.stock

    # On affiche le détail pour ce produit
    Write-Output "$($produit.nom) : $valeurProduit euros en stock"

    # On ajoute la valeur de ce produit au total cumulé
    $valeurTotaleStock += $valeurProduit   # += veut dire "ajoute ceci à la valeur actuelle"
}

# Une fois la boucle terminée, on affiche le total
Write-Output "Valeur totale du stock : $valeurTotaleStock euros"