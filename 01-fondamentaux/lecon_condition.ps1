$age = 18
if ($age -ge 18) {
    Write-Output "You are Major"
} elseif ($age -ge 13) {
    Write-Output "You are Teenager"
} else {
    Write-Output "You are Child"
}