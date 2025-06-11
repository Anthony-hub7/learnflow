import pymysql
from .db import DB

class DocumentTagModel(DB):
    """
    Classe modèle pour gérer la relation many-to-many entre les documents et les tags.
    Hérite de la classe DB pour gérer les opérations de base de données.
    Ce modèle gère l'association entre les documents et leurs tags, permettant
    la catégorisation des documents et la recherche basée sur les tags.
    """

    def __init__(self):
        """Initialise DocumentTagModel en établissant une connexion à la base de données via la classe parente DB."""
        self.table = 'document_tags'  # Définition du nom de la table
        super().__init__()

    def all(self):
        """
        Récupère toutes les associations document-tag avec leurs informations associées.

        Retourne:
            list: Liste de dictionnaires contenant document_id, tag_id, tag_name,
                 et document_title pour toutes les relations document-tag
        """
        query = '''
            SELECT dt.document_id, dt.tag_id, t.name AS tag_name, d.title AS document_title
            FROM document_tags dt
            LEFT JOIN tags t ON t.id = dt.tag_id
            LEFT JOIN documents d ON d.id = dt.document_id
        '''
        return self.fetchall(query)

    def get_by_document(self, document_id):
        """
        Récupère tous les tags associés à un document spécifique.

        Arguments:
            document_id (int): L'identifiant unique du document

        Retourne:
            list: Liste de dictionnaires contenant les informations des tags (id, nom)
                 pour tous les tags associés au document
        """
        query = '''
            SELECT t.id, t.name 
            FROM tags t 
            INNER JOIN document_tags dt ON t.id = dt.tag_id 
            WHERE dt.document_id = %s
        '''
        return self.fetchall(query, (document_id,))

    def get_by_tag(self, tag_id):
        """
        Récupère tous les documents associés à un tag spécifique.

        Arguments:
            tag_id (int): L'identifiant unique du tag

        Retourne:
            list: Liste de dictionnaires contenant les informations des documents
                 et le nom du tag pour tous les documents avec ce tag
        """
        query = '''
            SELECT d.*, t.name as tag_name 
            FROM documents d
            INNER JOIN document_tags dt ON d.id = dt.document_id
            INNER JOIN tags t ON t.id = dt.tag_id
            WHERE dt.tag_id = %s
        '''
        return self.fetchall(query, (tag_id,))

    def add(self, document_id, tag_id):
        """
        Associe un tag à un document.

        Arguments:
            document_id (int): L'identifiant unique du document
            tag_id (int): L'identifiant unique du tag

        Retourne:
            int: 1 si succès (y compris si la relation existe déjà),
                 0 si échec

        Note:
            Si l'association existe déjà, la méthode retournera 1
            sans créer d'entrée en double.
        """
        try:
            return self.execute_and_rowcount(
                'INSERT INTO document_tags (document_id, tag_id) VALUES (%s, %s)', 
                (document_id, tag_id)
            )
        except pymysql.err.IntegrityError:
            # Si la relation existe déjà, on ne considère pas ça comme une erreur
            return 1

    def add_multiple(self, document_id, tag_ids):
        """
        Associe plusieurs tags à un document.

        Arguments:
            document_id (int): L'identifiant unique du document
            tag_ids (list): Liste des IDs de tags à associer au document

        Retourne:
            bool: True si toutes les associations ont réussi, False si une a échoué
        """
        success = True
        for tag_id in tag_ids:
            try:
                if not self.add(document_id, tag_id):
                    success = False
            except:
                success = False
        return success

    def add_to_multiple(self, document_ids, tag_id):
        """
        Associe un tag à plusieurs documents.

        Arguments:
            document_ids (list): Liste des IDs de documents à associer au tag
            tag_id (int): L'identifiant unique du tag

        Retourne:
            bool: True si toutes les associations ont réussi, False si une a échoué
        """
        success = True
        for document_id in document_ids:
            try:
                if not self.add(document_id, tag_id):
                    success = False
            except:
                success = False
        return success

    def remove(self, document_id, tag_id):
        """
        Supprime l'association entre un document et un tag.

        Arguments:
            document_id (int): L'identifiant unique du document
            tag_id (int): L'identifiant unique du tag

        Retourne:
            int: Nombre de lignes affectées (devrait être 1 si succès)
        """
        return self.execute_and_rowcount(
            'DELETE FROM document_tags WHERE document_id = %s AND tag_id = %s', 
            (document_id, tag_id)
        )

    def clear(self, document_id):
        """
        Supprime tous les tags associés à un document.

        Arguments:
            document_id (int): L'identifiant unique du document

        Retourne:
            int: Nombre de lignes affectées
        """
        return self.execute_and_rowcount(
            'DELETE FROM document_tags WHERE document_id = %s', 
            (document_id,)
        )

    def clear_tag(self, tag_id):
        """
        Supprime tous les documents associés à un tag.

        Arguments:
            tag_id (int): L'identifiant unique du tag

        Retourne:
            int: Nombre de lignes affectées
        """
        return self.execute_and_rowcount(
            'DELETE FROM document_tags WHERE tag_id = %s',
            (tag_id,)
        )

    def get_document_count_by_tag(self):
        """
        Récupère le nombre de documents associés à chaque tag.

        Retourne:
            list: Liste de dictionnaires contenant les informations des tags et le nombre de documents:
                - id: L'identifiant unique du tag
                - name: Le nom du tag
                - document_count: Nombre de documents associés à ce tag
        """
        query = '''
            SELECT t.id, t.name, COUNT(dt.document_id) as document_count
            FROM tags t
            LEFT JOIN document_tags dt ON t.id = dt.tag_id
            GROUP BY t.id, t.name
            ORDER BY t.name
        '''
        return self.fetchall(query)
