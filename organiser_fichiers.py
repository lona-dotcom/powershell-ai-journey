import os
import shutil
import re
from pathlib import Path

# Dossier racine du projet
RACINE = Path(__file__).parent

# Règles de classification (regex → dossier)
REGLES = {
    r'\.ps1$': 'scripts-utilitaires',
    r'\.py$': 'scripts-utilitaires',
    r'\.csv$': 'data',
    r'\.json$': 'data',
    r'\.xml$': 'data',
    r'\.txt$': 'data',
    r'\.md$': 'docs',
    r'\.pdf$': 'docs',
    r'\.ipynb$': '03-ia-integration',
    r'.*fondamentaux.*\.ps1': '01-fondamentaux',
    r'.*avance.*\.ps1': '02-avancees',
    r'.*ia.*\.py': '03-ia-integration',
    r'.*projet.*\.py': '04-projets-experts',
}

def organiser_fichiers():
    # Lister tous les fichiers du dossier racine
    for fichier in RACINE.iterdir():
        if fichier.is_file():
            nom = fichier.name
            
            # Ignorer les fichiers système et scripts d'organisation
            if nom in ['.env', '.gitignore', 'README.md', 
                       'Setup-projet.ps1', 'Organiser-Fichiers.ps1',
                       'organiser_fichiers.py']:
                continue
            
            destination = None
            
            # Appliquer les règles
            for pattern, dossier in REGLES.items():
                if re.search(pattern, nom, re.IGNORECASE):
                    destination = dossier
                    break
            
            # Si destination trouvée, déplacer le fichier
            if destination:
                dossier_dest = RACINE / destination
                dossier_dest.mkdir(exist_ok=True)
                
                chemin_dest = dossier_dest / nom
                shutil.move(str(fichier), str(chemin_dest))
                print(f"📁 Déplacé : {nom} → {destination}/")
            else:
                print(f"⚠️  Aucune règle pour : {nom}")

if __name__ == "__main__":
    print("🚀 Organisation des fichiers...")
    organiser_fichiers()
    print("✅ Terminé !")