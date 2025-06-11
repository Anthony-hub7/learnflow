import pymysql
from .db import DB
import os

class categoriesModel(DB):
    def __init__(self):
        super().__init__()

    def all(self):
        return self.fetchall('SELECT * FROM categories')

    def get(self, id):
        return self.fetchone('SELECT * FROM categories WHERE id=%s', (id,))

    def create(self, name, description=None):
        return self.execute_and_lastrowid('INSERT INTO categories (name, description) VALUES (%s, %s)', (name, description))

    def update(self, id, name, description=None):
        return self.execute_and_rowcount('UPDATE categories SET name=%s, description=%s WHERE id=%s', (name, description, id))

    def delete(self, id):
        return self.execute_and_rowcount('DELETE FROM categories WHERE id=%s', (id,))

    def get_subjects(self, category_id):
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
