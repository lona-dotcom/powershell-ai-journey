$a=10
$b= '$a' # En guillemet simple, la variable n'est pas évaluée, elle est considérée comme une chaîne de caractères. En guillemet double, la variable est évaluée et sa valeur est affichée.
Write-Output "La valeur de la variable b est: $b"