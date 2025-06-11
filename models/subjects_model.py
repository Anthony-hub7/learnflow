import pymysql
from .db import DB
import os

class subjectsModel(DB):
    def __init__(self):
        super().__init__()

    def all(self):
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
        return self.execute_and_lastrowid(
            'INSERT INTO subjects (name, category_id, description) VALUES (%s, %s, %s)',
            (name, category_id, description)
        )

    def update(self, id, name, category_id=None, description=None):
        return self.execute_and_rowcount(
            'UPDATE subjects SET name=%s, category_id=%s, description=%s WHERE id=%s',
            (name, category_id, description, id)
        )

    def delete(self, id):
        return self.execute_and_rowcount('DELETE FROM subjects WHERE id=%s', (id,))

    def subjects_by_category(self, category_id):
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
        """Récupère tous les documents associés à une matière"""
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
