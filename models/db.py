import pymysql
from dotenv import load_dotenv
import os

load_dotenv(override=True)

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
            self.connection = pymysql.connect(
                host=os.getenv('DB_HOST'),
                user=os.getenv('DB_USER'),
                password=os.getenv('DB_PASSWORD'),
                database=os.getenv('DB_NAME'),
                port=int(os.getenv('DB_PORT')),
                charset='utf8mb4',
                cursorclass=pymysql.cursors.DictCursor
            )
        except Exception as e:
            print(f"Erreur de connexion à la base de données: {str(e)}")
            print(f"Paramètres de connexion:")
            print(f"Hôte: {os.getenv('DB_HOST')}")
            print(f"Utilisateur: {os.getenv('DB_USER')}")
            print(f"Base de données: {os.getenv('DB_NAME')}")
            print(f"Port: {os.getenv('DB_PORT')}")
            raise

    def fetchall(self, sql, params=None):
        """
        Exécute une requête SELECT et retourne toutes les lignes correspondantes.

        Arguments:
            sql (str): Requête SQL à exécuter
            params (tuple, optionnel): Paramètres à substituer dans la requête. Par défaut None.

        Retourne:
            list: Liste de dictionnaires, chacun représentant une ligne du résultat.
        """
        with self.connection.cursor() as cursor:
            cursor.execute(sql, params or ())
            return cursor.fetchall()

    def fetchone(self, sql, params=None):
        """
        Exécute une requête SELECT et retourne la première ligne correspondante.

        Arguments:
            sql (str): Requête SQL à exécuter
            params (tuple, optionnel): Paramètres à substituer dans la requête. Par défaut None.

        Retourne:
            dict: Dictionnaire représentant la première ligne du résultat,
                 ou None si aucune ligne n'est trouvée.
        """
        with self.connection.cursor() as cursor:
            cursor.execute(sql, params or ())
            return cursor.fetchone()

    def execute_and_lastrowid(self, sql, params=None):
        """
        Exécute une requête INSERT et retourne l'ID de la dernière ligne insérée.

        Arguments:
            sql (str): Requête SQL à exécuter (typiquement INSERT)
            params (tuple, optionnel): Paramètres à substituer dans la requête. Par défaut None.

        Retourne:
            int: ID de la dernière ligne insérée
        """
        with self.connection.cursor() as cursor:
            cursor.execute(sql, params or ())
            self.connection.commit()
            return cursor.lastrowid

    def execute_and_rowcount(self, sql, params=None):
        """
        Exécute une requête UPDATE ou DELETE et retourne le nombre de lignes affectées.

        Arguments:
            sql (str): Requête SQL à exécuter (typiquement UPDATE ou DELETE)
            params (tuple, optionnel): Paramètres à substituer dans la requête. Par défaut None.

        Retourne:
            int: Nombre de lignes affectées par la requête
        """
        with self.connection.cursor() as cursor:
            cursor.execute(sql, params or ())
            self.connection.commit()
            return cursor.rowcount

    def close(self):
        """
        Ferme la connexion à la base de données.
        Doit être appelé une fois les opérations terminées pour libérer les ressources.
        """
        self.connection.close()

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
