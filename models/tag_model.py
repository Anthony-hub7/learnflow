import pymysql
from .db import DB

class TagModel(DB):
    def __init__(self):
        super().__init__()

    def all(self):
        query = 'SELECT * FROM tags ORDER BY name ASC'
        return self.fetchall(query)

    def get(self, id):
        return self.fetchone('SELECT * FROM tags WHERE id=%s', (id,))

    def create(self, name):
        return self.execute_and_lastrowid(
            'INSERT INTO tags (name) VALUES (%s)', (name,)
        )

    def update(self, id, name):
        return self.execute_and_rowcount(
            'UPDATE tags SET name=%s WHERE id=%s', (name, id)
        )

    def delete(self, id):
        return self.execute_and_rowcount('DELETE FROM tags WHERE id=%s', (id,))
