import mysql.connector

try:
    conn = mysql.connector.connect(
        host="localhost",
        user="root",
        password="",  # sua senha, se tiver
        database="eg"
    )
    print("Conexão bem-sucedida!")
except mysql.connector.Error as err:
    print("Erro:", err)
