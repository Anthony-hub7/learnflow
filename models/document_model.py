import pymysql
from .db import DB

class DocumentModel(DB):
    """
    Classe modèle pour la gestion des documents dans l'application LearnFlow.
    Hérite de la classe DB pour gérer les opérations de base de données.
    Les documents représentent les supports d'apprentissage qui peuvent être téléchargés,
    catégorisés et associés à des matières et des tags.
    """

    def __init__(self):
        """Initialise DocumentModel en établissant une connexion à la base de données via la classe parente DB."""
        super().__init__()

    def all(self):
        """
        Récupère tous les documents de la base de données avec leurs informations de matière associée.

        Retourne:
            list: Liste de dictionnaires contenant les informations des documents incluant:
                - id: L'identifiant unique du document
                - title: Titre du document
                - type: Type du document
                - description: Description du document
                - subject_id: ID de la matière associée
                - file_name: Nom d'origine du fichier uploadé
                - mime_type: Type MIME du document
                - created_at: Horodatage de création
                - updated_at: Horodatage de dernière mise à jour
                - subject_name: Nom de la matière associée
        """
        query = '''
            SELECT 
                documents.id,
                documents.title,
                documents.type,
                documents.description,
                documents.subject_id,
                documents.file_name,
                documents.mime_type,
                documents.created_at,
                documents.updated_at,
                subjects.name AS subject_name
            FROM documents
            LEFT JOIN subjects ON documents.subject_id = subjects.id
        '''
        return self.fetchall(query)

    def get(self, id):
        """
        Récupère un document spécifique par son ID.

        Arguments:
            id (int): L'identifiant unique du document

        Retourne:
            dict: Informations du document incluant toutes les métadonnées et le contenu du fichier
                 si trouvé, None sinon
        """
        query = '''
            SELECT 
                documents.id,
                documents.title,
                documents.type,
                documents.description,
                documents.subject_id,
                documents.file_name,
                documents.mime_type,
                documents.file_content,
                documents.created_at,
                documents.updated_at,
                subjects.name AS subject_name
            FROM documents
            LEFT JOIN subjects ON documents.subject_id = subjects.id
            WHERE documents.id = %s
        '''
        return self.fetchone(query, (id,))

    def create(self, title, type, subject_id, file_name, mime_type, file_content, description=None):
        """
        Crée un nouveau document dans la base de données.

        Arguments:
            title (str): Le titre du document
            type (str): Le type/catégorie du document
            subject_id (int): L'ID de la matière à laquelle ce document appartient
            file_name (str): Nom d'origine du fichier uploadé
            mime_type (str): Type MIME du document
            file_content (bytes): Contenu binaire du fichier
            description (str, optionnel): Une description du document. Par défaut None.

        Retourne:
            int: ID du document nouvellement créé
        """
        return self.execute_and_lastrowid('''
            INSERT INTO documents (title, type, subject_id, file_name, mime_type, file_content, description)
            VALUES (%s, %s, %s, %s, %s, %s, %s)
        ''', (title, type, subject_id, file_name, mime_type, file_content, description))

    def update(self, id, title, type, subject_id, file_name, mime_type, file_content, description=None):
        """
        Met à jour les informations d'un document existant dans la base de données.

        Arguments:
            id (int): L'identifiant unique du document à mettre à jour
            title (str): Le nouveau titre du document
            type (str): Le nouveau type/catégorie du document
            subject_id (int): Le nouvel ID de la matière à laquelle ce document appartient
            file_name (str): Le nouveau nom d'origine du fichier uploadé
            mime_type (str): Le nouveau type MIME du document
            file_content (bytes): Le nouveau contenu binaire du fichier
            description (str, optionnel): Une nouvelle description du document. Par défaut None.

        Retourne:
            int: Nombre de lignes affectées par la mise à jour
        """
        return self.execute_and_rowcount('''
            UPDATE documents 
            SET title=%s, type=%s, subject_id=%s, file_name=%s, mime_type=%s, file_content=%s, description=%s 
            WHERE id=%s
        ''', (title, type, subject_id, file_name, mime_type, file_content, description, id))

    def delete(self, id):
        """
        Supprime un document de la base de données.

        Arguments:
            id (int): L'identifiant unique du document à supprimer

        Retourne:
            int: Nombre de lignes affectées par la suppression
        """
        return self.execute_and_rowcount('DELETE FROM documents WHERE id=%s', (id,))
