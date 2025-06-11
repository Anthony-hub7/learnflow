import pymysql
from dotenv import load_dotenv
import os

load_dotenv(override=True)

class DB:
    def __init__(self):
        try:
            self.connection = pymysql.connect(
                host=os.getenv('DB_HOST'),
                user=os.getenv('DB_USER'),
                password=os.getenv('DB_PASSWORD'),
                database=os.getenv('DB_NAME'),
                port=int(os.getenv('DB_PORT')),
                charset='utf8mb4',
                cursorclass=pymysql.cursors.DictCursor
            )
        except Exception as e:
            print(f"Database connection error: {str(e)}")
            print(f"Connection parameters:")
            print(f"Host: {os.getenv('DB_HOST')}")
            print(f"User: {os.getenv('DB_USER')}")
            print(f"Database: {os.getenv('DB_NAME')}")
            print(f"Port: {os.getenv('DB_PORT')}")
            raise

    def fetchall(self, sql, params=None):
        with self.connection.cursor() as cursor:
            cursor.execute(sql, params or ())
            return cursor.fetchall()

    def fetchone(self, sql, params=None):
        with self.connection.cursor() as cursor:
            cursor.execute(sql, params or ())
            return cursor.fetchone()

    def execute_and_lastrowid(self, sql, params=None):
        with self.connection.cursor() as cursor:
            cursor.execute(sql, params or ())
            self.connection.commit()
            return cursor.lastrowid

    def execute_and_rowcount(self, sql, params=None):
        with self.connection.cursor() as cursor:
            cursor.execute(sql, params or ())
            self.connection.commit()
            return cursor.rowcount

    def close(self):
        self.connection.close()

def test_db_connection():
    try:
        db = DB()
        db.close()
        return 'Connexion à la base de données réussie !'
    except Exception as e:
        return f'Erreur de connexion : {e}'

if __name__ == '__main__':
    print(test_db_connection())
