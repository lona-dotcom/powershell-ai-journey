$temperatureCelsius = 21
$temperatureFahrenheit = ($temperatureCelsius * 9/5) + 32
Write-Output "The temperature in Celsius is: $temperatureCelsius °C et in Fahrenheit is: $temperatureFahrenheit °F"
Remove-Variable -Name temperatureCelsius
Get-Variable -Name temperatureCelsius -ErrorAction SilentlyContinue