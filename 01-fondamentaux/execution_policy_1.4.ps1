Set-ExecutionPolicy Undefined -Scope CurrentUser -Force
$actual_policy = Get-ExecutionPolicy -Scope CurrentUser
if ($actual_policy -eq "RemoteSigned") {
    Write-Output "Tout est en ordre."
} 
else {
    Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
    Write-Output "La stratégie d'exécution a été modifiée pour RemoteSigned."
}