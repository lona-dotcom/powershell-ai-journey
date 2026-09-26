function Dire-Bonjour {
    param (
        [string]$nom,
        [int]$age
    )
    return "Bonjour $nom!, tu as $age ans."
}
$resultat = Dire-Bonjour -nom "Léa" -age 28
Write-Output $resultat