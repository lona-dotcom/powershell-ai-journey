$nombre = -1

if ($nombre -gt 0) {
    Write-Output "Positif"
} elseif ($nombre -lt 0) {
    Write-Output "Négatif"
} else {
    Write-Output "Nul"
}