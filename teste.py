import mysql.connector


db_config = {
    "host": "localhost",
    "user": "root",
    "password": "",
    "database": "eg"
}

nome = 'BioWare'

conn = mysql.connector.connect(**db_config)
cursor = conn.cursor()

cursor.execute("SELECT cod_Desenvolvedor FROM Desenvolvedor WHERE nome_Desenvolvedor = %s", (nome,))
registro = cursor.fetchone()

print(registro[0])