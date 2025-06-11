import pymysql
from .db import DB

class TagModel(DB):
    """
    Classe modèle pour la gestion des tags dans l'application LearnFlow.
    Hérite de la classe DB pour gérer les opérations de base de données.
    Les tags sont utilisés pour catégoriser et organiser les documents.
    """

    def __init__(self):
        """Initialise TagModel en établissant une connexion à la base de données via la classe parente DB."""
        super().__init__()

    def all(self):
        """
        Récupère tous les tags de la base de données, triés alphabétiquement par nom.

        Retourne:
            list: Liste de dictionnaires contenant les informations des tags (id, nom)
        """
        query = 'SELECT * FROM tags ORDER BY name ASC'
        return self.fetchall(query)

    def get(self, id):
        """
        Récupère un tag spécifique par son ID.

        Arguments:
            id (int): L'identifiant unique du tag

        Retourne:
            dict: Informations du tag (id, nom) si trouvé, None sinon
        """
        return self.fetchone('SELECT * FROM tags WHERE id=%s', (id,))

    def create(self, name):
        """
        Crée un nouveau tag dans la base de données.

        Arguments:
            name (str): Le nom du tag à créer

        Retourne:
            int: ID du tag nouvellement créé
        """
        return self.execute_and_lastrowid(
            'INSERT INTO tags (name) VALUES (%s)', (name,)
        )

    def update(self, id, name):
        """
        Met à jour le nom d'un tag existant.

        Arguments:
            id (int): L'identifiant unique du tag à mettre à jour
            name (str): Le nouveau nom pour le tag

        Retourne:
            int: Nombre de lignes affectées (1 si succès, 0 si tag non trouvé)
        """
        return self.execute_and_rowcount(
            'UPDATE tags SET name=%s WHERE id=%s', (name, id)
        )

    def delete(self, id):
        """
        Supprime un tag de la base de données.

        Arguments:
            id (int): L'identifiant unique du tag à supprimer

        Retourne:
            int: Nombre de lignes affectées (1 si succès, 0 si tag non trouvé)
        """
        return self.execute_and_rowcount('DELETE FROM tags WHERE id=%s', (id,))
