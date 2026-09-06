# .git/hooks/pre-commit
#!/bin/bash

echo "🔧 Organisation des fichiers avant commit..."
python organiser_fichiers.py
git add .
echo "✅ Fichiers organisés et ajoutés au commit"