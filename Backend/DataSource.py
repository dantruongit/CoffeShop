import mysql.connector
from Models import *

def validate_string(string: str):
    return string.isalnum()

class SqlConnector:
    def __init__(self):
        self.conn = mysql.connector.connect(
            host="localhost",
            user="root",
            password="",
            database="coffe"
        )
        self.cursor = self.conn.cursor()

    def execute_query(self, query):
        self.cursor.execute(query)
        return self.cursor.fetchall()
    
    def execute_insert_query(self, query):
        self.cursor.execute(query)
        self.conn.commit()

    def stop(self):
        self.cursor.close()
        self.conn.close()

class DataSource:
    def __init__(self):
        self.sql = SqlConnector()
        pass
    
    def get_user(self, username: str, password: str) -> User:
        if validate_string(username) == False or validate_string(password) == False:
            return None
        query = f"SELECT * FROM User WHERE username = '{username}' AND password = '{password}'"
        result = self.sql.execute_query(query)
        if len(result) > 0:
            return User(result[0])
        return None
    
    def add_user(self, username: str, password: str, fullname: str) -> bool:
        if validate_string(username) == False or validate_string(password) == False:
            return False
        if self.get_user(username, password) != None:
            return False
        try:
            query = f"INSERT INTO User(username, password, imagePath, name) VALUES('{username}', '{password}','http://localhost/avatar/nidalee.png', '{fullname}')"
            self.sql.execute_insert_query(query)
            return True
        except:
            return False
        
    def get_coffe_by_id(self, id: str) -> Coffe:
        query = f"SELECT * FROM Coffe WHERE id = '{id}'"
        result = self.sql.execute_query(query)
        if len(result) > 0:
            return Coffe(result[0])
        return None