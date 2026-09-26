$jour = "Mercredi"
switch ($jour) {
    "Lundi" {
        Write-Output "Debut de la  semaine"
    }
    "Mercredi" {
        Write-Output "Milieu de la semaine"
    }
    "Vendredi" {
        Write-Output "Fin de la semaine"
    }
    default {
        Write-Output "Jour normal"
    }
}