import pymysql
from .db import DB

class DocumentModel(DB):
    def __init__(self):
        super().__init__()

    def all(self):
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
        return self.execute_and_lastrowid('''
            INSERT INTO documents (title, type, subject_id, file_name, mime_type, file_content, description)
            VALUES (%s, %s, %s, %s, %s, %s, %s)
        ''', (title, type, subject_id, file_name, mime_type, file_content, description))

    def update(self, id, title, type, subject_id, file_name, mime_type, file_content, description=None):
        return self.execute_and_rowcount('''
            UPDATE documents 
            SET title=%s, type=%s, subject_id=%s, file_name=%s, mime_type=%s, file_content=%s, description=%s 
            WHERE id=%s
        ''', (title, type, subject_id, file_name, mime_type, file_content, description, id))

    def delete(self, id):
        return self.execute_and_rowcount('DELETE FROM documents WHERE id=%s', (id,))
