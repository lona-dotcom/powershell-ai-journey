for ($nombre = 1; $nombre -le 10; $nombre++) {
    if ($nombre % 2 -eq 0) {
        Write-Host $nombre
    } else {
        $null
    }
}