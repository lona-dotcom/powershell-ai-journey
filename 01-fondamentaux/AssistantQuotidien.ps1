function Get-MessageDuJour {
    param (
        [int]$Heure = (Get-Date).Hour
    )
   if ($Heure -gt 6 -and $Heure -lt 12) {
        return "Bonjour ! Bien dormi ?"
   }
   elseif ($Heure -ge 12 -and $Heure -lt 13) {
        return "Bon appétit !"
   }
    elseif ($Heure -ge 13 -and $Heure -lt 18) {
        return "Bonne après-midi !"
    }
    else {
        return "Bonne soirée !"
    }
}
Write-Output (Get-MessageDuJour)