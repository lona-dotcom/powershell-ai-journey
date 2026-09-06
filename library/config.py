# library/config.py
import os
from pathlib import Path
from dotenv import load_dotenv

# Charger .env
BASE_DIR = Path(__file__).parent.parent
ENV_FILE = BASE_DIR / '.env'
load_dotenv(ENV_FILE)

class Config:
    \"\"\"Configuration centralisée du projet\"\"\"
    
    # === IA ===
    OPENAI_API_KEY = os.getenv('OPENAI_API_KEY')
    ANTHROPIC_API_KEY = os.getenv('ANTHROPIC_API_KEY')
    HUGGINGFACE_API_KEY = os.getenv('HUGGINGFACE_API_KEY')
    GOOGLE_AI_API_KEY = os.getenv('GOOGLE_AI_API_KEY')
    
    # === MODÈLES ===
    MODEL_NAME = os.getenv('MODEL_NAME', 'gpt-4-turbo')
    TEMPERATURE = float(os.getenv('TEMPERATURE', 0.7))
    MAX_TOKENS = int(os.getenv('MAX_TOKENS', 4096))
    
    # === BASE DE DONNÉES ===
    MONGODB_URI = os.getenv('MONGODB_URI')
    POSTGRES_HOST = os.getenv('POSTGRES_HOST', 'localhost')
    POSTGRES_PORT = int(os.getenv('POSTGRES_PORT', 5432))
    POSTGRES_USER = os.getenv('POSTGRES_USER', 'admin')
    POSTGRES_PASSWORD = os.getenv('POSTGRES_PASSWORD')
    POSTGRES_DB = os.getenv('POSTGRES_DB', 'ai_journey')
    
    # === STOCKAGE ===
    AZURE_STORAGE_CONNECTION_STRING = os.getenv('AZURE_STORAGE_CONNECTION_STRING')
    AWS_ACCESS_KEY_ID = os.getenv('AWS_ACCESS_KEY_ID')
    AWS_SECRET_ACCESS_KEY = os.getenv('AWS_SECRET_ACCESS_KEY')
    S3_BUCKET_NAME = os.getenv('S3_BUCKET_NAME', 'ai-journey-data')
    
    # === PROJET ===
    PROJECT_ENV = os.getenv('PROJECT_ENV', 'development')
    LOG_LEVEL = os.getenv('LOG_LEVEL', 'INFO')
    
    @classmethod
    def validate(cls):
        \"\"\"Vérifier que les clés essentielles sont présentes\"\"\"
        required = ['OPENAI_API_KEY']
        missing = [key for key in required if not getattr(cls, key)]
        if missing:
            print(f"❌ Variables manquantes : {missing}")
            return False
        print("✅ Configuration validée !")
        return True
    
    @classmethod
    def summary(cls):
        \"\"\"Afficher un résumé de la configuration\"\"\"
        print("="*50)
        print("📋 CONFIGURATION DU PROJET")
        print("="*50)
        print(f"🔹 Environnement : {cls.PROJECT_ENV}")
        print(f"🔹 Modèle IA : {cls.MODEL_NAME}")
        print(f"🔹 Température : {cls.TEMPERATURE}")
        print(f"🔹 Max tokens : {cls.MAX_TOKENS}")
        print(f"🔹 Log level : {cls.LOG_LEVEL}")
        print(f"🔹 OpenAI : {'✅' if cls.OPENAI_API_KEY else '❌'}")
        print(f"🔹 Anthropic : {'✅' if cls.ANTHROPIC_API_KEY else '❌'}")
        print("="*50)

config = Config()

if __name__ == "__main__":
    Config.summary()
    Config.validate()
