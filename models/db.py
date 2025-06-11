import pymysql
import pymysql.cursors
from dotenv import load_dotenv
import os

# Chargement des variables d'environnement
load_dotenv()

class DB:
    """
    Classe de base pour la gestion des connexions à la base de données.
    Utilise les variables d'environnement pour les paramètres de connexion et fournit
    des opérations courantes comme la récupération et l'exécution de requêtes.
    """

    def __init__(self):
        """
        Initialise la connexion à la base de données en utilisant les variables d'environnement.
        Établit une connexion MySQL avec l'encodage UTF-8 et un curseur de type dictionnaire
        pour retourner les résultats sous forme de dictionnaires.

        Lève:
            Exception: Si la connexion échoue, affiche les paramètres de connexion détaillés
                      et relève l'exception d'origine.
        """
        try:
            self.conn = pymysql.connect(
                host=os.getenv('DB_HOST', 'localhost'),
                user=os.getenv('DB_USER', 'root'),
                password=os.getenv('DB_PASSWORD', ''),
                db=os.getenv('DB_NAME', 'learnflow'),
                charset=os.getenv('DB_CHARSET', 'utf8mb4'),
                cursorclass=pymysql.cursors.DictCursor
            )
        except pymysql.Error as e:
            print(f"Error connecting to MySQL Platform: {e}")
            print(f"Using configuration:")
            print(f"Host: {os.getenv('DB_HOST', 'localhost')}")
            print(f"User: {os.getenv('DB_USER', 'root')}")
            print(f"Database: {os.getenv('DB_NAME', 'learnflow')}")
            raise

    def execute(self, query, params=()):
        """Exécute une requête SQL et retourne le curseur"""
        cursor = self.conn.cursor()
        cursor.execute(query, params)
        return cursor

    def fetchall(self, query, params=()):
        """Exécute une requête et retourne tous les résultats"""
        cursor = self.execute(query, params)
        result = cursor.fetchall()
        cursor.close()
        return result

    def fetchone(self, query, params=()):
        """Exécute une requête et retourne un seul résultat"""
        cursor = self.execute(query, params)
        result = cursor.fetchone()
        cursor.close()
        return result

    def execute_and_commit(self, query, params=()):
        """Exécute une requête et effectue un commit"""
        cursor = self.execute(query, params)
        self.conn.commit()
        cursor.close()

    def execute_and_lastrowid(self, query, params=()):
        """Exécute une requête et retourne l'ID de la dernière ligne insérée"""
        cursor = self.execute(query, params)
        self.conn.commit()
        last_id = cursor.lastrowid
        cursor.close()
        return last_id

    def execute_and_rowcount(self, query, params=()):
        """Exécute une requête et retourne le nombre de lignes affectées"""
        cursor = self.execute(query, params)
        self.conn.commit()
        rowcount = cursor.rowcount
        cursor.close()
        return rowcount

    def close(self):
        """Ferme la connexion à la base de données"""
        if hasattr(self, 'conn'):
            self.conn.close()

def test_db_connection():
    """
    Teste la connexion à la base de données en essayant de créer une instance DB.

    Retourne:
        str: Message de succès si la connexion réussit, message d'erreur si elle échoue
    """
    try:
        db = DB()
        db.close()
        return 'Connexion à la base de données réussie !'
    except Exception as e:
        return f'Erreur de connexion : {e}'

if __name__ == '__main__':
    print(test_db_connection())
