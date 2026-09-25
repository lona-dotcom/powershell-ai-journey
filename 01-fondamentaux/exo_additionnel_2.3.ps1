$date = (Get-Date).Year.ToString() + "-" + (Get-Date).Month.ToString("00") + "-" + (Get-Date).Day.ToString("00") + " " + (Get-Date).Hour.ToString("00") + ":" + (Get-Date).Minute.ToString("00") + ":" + (Get-Date).Second.ToString("00")       
Write-Output "La date et l'heure actuelles sont : $date"
