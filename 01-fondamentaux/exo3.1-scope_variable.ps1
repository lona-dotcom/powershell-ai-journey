$x = 10
function modifier_variable {
    $x = 99
}
modifier_variable
Write-Output "La valeur de x après l'appel de la fonction est : $x"