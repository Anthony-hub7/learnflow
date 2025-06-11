import pymysql
from .db import DB
import os

class categoriesModel(DB):
    """
    Classe modèle pour la gestion des catégories dans l'application LearnFlow.
    Hérite de la classe DB pour gérer les opérations de base de données.
    Les catégories sont utilisées pour organiser les matières en domaines thématiques plus larges.
    """

    def __init__(self):
        """Initialise CategoriesModel en établissant une connexion à la base de données via la classe parente DB."""
        self.table = 'categories'  # Définition du nom de la table
        super().__init__()

    def all(self):
        """
        Récupère toutes les catégories de la base de données.

        Retourne:
            list: Liste de dictionnaires contenant les informations de catégorie (id, nom, description)
        """
        return self.fetchall('SELECT * FROM categories')

    def get(self, id):
        """
        Récupère une catégorie spécifique par son ID.

        Arguments:
            id (int): L'identifiant unique de la catégorie

        Retourne:
            dict: Informations de la catégorie si trouvée, None sinon
        """
        return self.fetchone('SELECT * FROM categories WHERE id=%s', (id,))

    def create(self, name, description=None):
        """
        Crée une nouvelle catégorie dans la base de données.

        Arguments:
            name (str): Le nom de la catégorie
            description (str, optionnel): Une description de la catégorie. Par défaut None.

        Retourne:
            int: ID de la catégorie nouvellement créée
        """
        return self.execute_and_lastrowid('INSERT INTO categories (name, description) VALUES (%s, %s)', (name, description))

    def update(self, id, name, description=None):
        """
        Met à jour les informations d'une catégorie existante.

        Arguments:
            id (int): L'identifiant unique de la catégorie à mettre à jour
            name (str): Le nouveau nom de la catégorie
            description (str, optionnel): La nouvelle description. Par défaut None.

        Retourne:
            int: Nombre de lignes affectées (1 si succès, 0 si catégorie non trouvée)
        """
        return self.execute_and_rowcount('UPDATE categories SET name=%s, description=%s WHERE id=%s', (name, description, id))

    def delete(self, id):
        """
        Supprime une catégorie de la base de données.

        Arguments:
            id (int): L'identifiant unique de la catégorie à supprimer

        Retourne:
            int: Nombre de lignes affectées (1 si succès, 0 si catégorie non trouvée)
        """
        return self.execute_and_rowcount('DELETE FROM categories WHERE id=%s', (id,))

    def get_subjects(self, category_id):
        """
        Récupère toutes les matières appartenant à une catégorie spécifique.

        Arguments:
            category_id (int): L'identifiant unique de la catégorie

        Retourne:
            list: Liste de dictionnaires contenant les informations des matières pour la catégorie,
                 incluant les détails des matières et le nom de la catégorie associée
        """
        query = '''
            SELECT 
                subjects.id,
                subjects.name,
                subjects.description,
                subjects.created_at,
                categories.name AS category_name
            FROM subjects
            LEFT JOIN categories ON subjects.category_id = categories.id
            WHERE subjects.category_id = %s
        '''
        return self.fetchall(query, (category_id,))
