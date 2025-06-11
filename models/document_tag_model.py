import pymysql
from .db import DB

class DocumentTagModel(DB):
    def __init__(self):
        super().__init__()

    def all(self):
        query = '''
            SELECT dt.document_id, dt.tag_id, t.name AS tag_name, d.title AS document_title
            FROM document_tags dt
            LEFT JOIN tags t ON t.id = dt.tag_id
            LEFT JOIN documents d ON d.id = dt.document_id
        '''
        return self.fetchall(query)

    def get_by_document(self, document_id):
        query = '''
            SELECT t.id, t.name 
            FROM tags t 
            INNER JOIN document_tags dt ON t.id = dt.tag_id 
            WHERE dt.document_id = %s
        '''
        return self.fetchall(query, (document_id,))

    def get_by_tag(self, tag_id):
        query = '''
            SELECT d.*, t.name as tag_name 
            FROM documents d
            INNER JOIN document_tags dt ON d.id = dt.document_id
            INNER JOIN tags t ON t.id = dt.tag_id
            WHERE dt.tag_id = %s
        '''
        return self.fetchall(query, (tag_id,))

    def add(self, document_id, tag_id):
        try:
            return self.execute_and_rowcount(
                'INSERT INTO document_tags (document_id, tag_id) VALUES (%s, %s)', 
                (document_id, tag_id)
            )
        except pymysql.err.IntegrityError:
            # Si le lien existe déjà, on ne considère pas ça comme une erreur
            return 1

    def add_multiple(self, document_id, tag_ids):
        success = True
        for tag_id in tag_ids:
            try:
                if not self.add(document_id, tag_id):
                    success = False
            except:
                success = False
        return success

    def add_to_multiple(self, document_ids, tag_id):
        success = True
        for document_id in document_ids:
            try:
                if not self.add(document_id, tag_id):
                    success = False
            except:
                success = False
        return success

    def remove(self, document_id, tag_id):
        return self.execute_and_rowcount(
            'DELETE FROM document_tags WHERE document_id = %s AND tag_id = %s', 
            (document_id, tag_id)
        )

    def clear(self, document_id):
        return self.execute_and_rowcount(
            'DELETE FROM document_tags WHERE document_id = %s', 
            (document_id,)
        )

    def clear_tag(self, tag_id):
        return self.execute_and_rowcount(
            'DELETE FROM document_tags WHERE tag_id = %s',
            (tag_id,)
        )

    def get_document_count_by_tag(self):
        query = '''
            SELECT t.id, t.name, COUNT(dt.document_id) as document_count
            FROM tags t
            LEFT JOIN document_tags dt ON t.id = dt.tag_id
            GROUP BY t.id, t.name
            ORDER BY t.name
        '''
        return self.fetchall(query)
