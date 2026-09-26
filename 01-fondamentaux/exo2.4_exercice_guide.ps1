function Get-Categorie {
    param(
        [int]$Age
    )

    if ($Age -lt 13) {
        return "Enfant"
    }
    elseif ($Age -le 17) {
        return "Adolescent"
    }
    else {
        return "Adulte"
    }
}

# Appels
Write-Host (Get-Categorie -Age 8)
Write-Host (Get-Categorie -Age 15)
Write-Host (Get-Categorie -Age 42)