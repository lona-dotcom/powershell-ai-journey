$participants = @(
    @{ nom = "Sitraka"; age = 16}
    @{ nom = "Rosia"; age = 20}
    @{ nom = "Erica"; age = 16}
    @{ nom = "Naval"; age = 18}
    @{ nom = "Miora"; age = 19}
    @{ nom = "Harilala"; age = 21}
    @{ nom = "Tsoa"; age = 22}
    @{ nom = "Natacha"; age = 19}
)
$majeurs = @()
$mineurs = @()
foreach ($participant in $participants) {
        if ($participant.age -ge 18) {
            Write-Output "$($participant.nom) est majeur(e) et peut participer."
            $majeurs += $participant
        } else {
            Write-Output "$($participant.nom) est mineur(e) et ne peut pas participer."
            $mineurs += $participant
        }
}   
Write-Output "Nombre de participants majeurs: $($majeurs.Count) dont les noms sont: $($majeurs.nom -join ', ')"
Write-Output "Nombre de participants mineurs: $($mineurs.Count) dont les noms sont: $($mineurs.nom -join ', ')"