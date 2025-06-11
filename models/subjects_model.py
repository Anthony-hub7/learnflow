import pymysql
from models.db import DB
import os

class subjectsModel(DB):
    """
    Classe modèle pour la gestion des matières dans l'application LearnFlow.
    Hérite de la classe DB pour gérer les opérations de base de données.
    Les matières représentent les domaines d'études principaux qui peuvent être assignés
    à des catégories et contenir des documents.
    """

    def __init__(self):
        """Initialise SubjectsModel en établissant une connexion à la base de données via la classe parente DB."""
        self.table = 'subjects'  # Définition du nom de la table
        super().__init__()  # Appel du constructeur parent après définition de self.table

    def all(self):
        """
        Récupère toutes les matières avec leurs informations de catégorie associée.

        Retourne:
            list: Liste de dictionnaires contenant les informations des matières incluant:
                 - id: L'identifiant unique de la matière
                 - name: Le nom de la matière
                 - description: La description de la matière
                 - created_at: Horodatage de création
                 - category_name: Nom de la catégorie associée (si existante)
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
        '''
        return self.fetchall(query)

    def get(self, id):
        """
        Récupère une matière spécifique par son ID, incluant les informations de catégorie.

        Arguments:
            id (int): L'identifiant unique de la matière

        Retourne:
            dict: Informations de la matière incluant les détails de catégorie si trouvée, None sinon
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
            WHERE subjects.id = %s
        '''
        return self.fetchone(query, (id,))

    def create(self, name, category_id=None, description=None):
        """
        Crée une nouvelle matière dans la base de données.

        Arguments:
            name (str): Le nom de la matière
            category_id (int, optionnel): L'ID de la catégorie à associer. Par défaut None.
            description (str, optionnel): Une description de la matière. Par défaut None.

        Retourne:
            int: ID de la matière nouvellement créée
        """
        return self.execute_and_lastrowid(
            'INSERT INTO subjects (name, category_id, description) VALUES (%s, %s, %s)',
            (name, category_id, description)
        )

    def update(self, id, name, category_id=None, description=None):
        """
        Met à jour les informations d'une matière existante.

        Arguments:
            id (int): L'identifiant unique de la matière à mettre à jour
            name (str): Le nouveau nom pour la matière
            category_id (int, optionnel): Le nouvel ID de catégorie. Par défaut None.
            description (str, optionnel): La nouvelle description. Par défaut None.

        Retourne:
            int: Nombre de lignes affectées (1 si succès, 0 si matière non trouvée)
        """
        return self.execute_and_rowcount(
            'UPDATE subjects SET name=%s, category_id=%s, description=%s WHERE id=%s',
            (name, category_id, description, id)
        )

    def delete(self, id):
        """
        Supprime une matière de la base de données.

        Arguments:
            id (int): L'identifiant unique de la matière à supprimer

        Retourne:
            int: Nombre de lignes affectées (1 si succès, 0 si matière non trouvée)
        """
        return self.execute_and_rowcount('DELETE FROM subjects WHERE id=%s', (id,))

    def subjects_by_category(self, category_id):
        """
        Récupère toutes les matières appartenant à une catégorie spécifique.

        Arguments:
            category_id (int): L'identifiant unique de la catégorie

        Retourne:
            list: Liste de dictionnaires contenant les informations des matières
                  dans la catégorie spécifiée, incluant:
                 - id: L'identifiant unique de la matière
                 - name: Le nom de la matière
                 - description: La description de la matière
                 - created_at: Horodatage de création
                 - category_name: Nom de la catégorie associée
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

    def get_documents(self, subject_id):
        """
        Récupère tous les documents associés à une matière.

        Arguments:
            subject_id (int): L'identifiant unique de la matière

        Retourne:
            list: Liste de dictionnaires contenant les informations des documents
                 associés à la matière spécifiée
        """
        query = '''
            SELECT 
                documents.id,
                documents.title,
                documents.type,
                documents.description,
                documents.file_name,
                documents.mime_type,
                documents.created_at,
                documents.updated_at,
                subjects.name AS subject_name
            FROM documents
            LEFT JOIN subjects ON documents.subject_id = subjects.id
            WHERE documents.subject_id = %s
            ORDER BY documents.created_at DESC
        '''
        return self.fetchall(query, (subject_id,))
