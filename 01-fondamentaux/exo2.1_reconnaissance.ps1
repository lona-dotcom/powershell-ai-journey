$notes = @(12, 8, 15, 19, 6)
$total = 0
foreach ($note in $notes) {
    $total += $note # ajoute la note courante au total accumulé
}
$moyenne = $total / $notes.Count #Calcul de la moyenne
if ($moyenne -ge 10) { #Condition si la moyenne est supérieure ou égale à 10
    Write-Output "Moyenne validée: $moyenne." # affiche la moyenne validée  
} else { #sinon, condition si la moyenne est inférieure à 10
    Write-Output "Moyenne insuffisante: $moyenne. Tu dois travailler plus dur." # affiche la moyenne insuffisante
}
