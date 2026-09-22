$prenom="Lea" #assignation variable prenom comme type string
$age=28 # assignation variable age comme type int
$EstEtudiant=$false # assignation variable EstEtudiant comme type bool
$message= "Bonjour $prenom, tu as $age ans. Est-ce que vous êtes étudiant? $EstEtudiant" # assignation variable message comme type string
Write-Output $message # affichage du message "Bonjour Lea, tu as 28 ans. Est-ce que vous êtes étudiant? False"
Remove-Variable -Name age # suppression de la variable age
Write-Output $age # affichage de la valeur de la variable age (sera une erreur car la variable a été supprimée)
