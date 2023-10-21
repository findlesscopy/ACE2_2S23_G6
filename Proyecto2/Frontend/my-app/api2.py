from flask import Flask, request, jsonify
import sqlite3
from pathlib import Path

app = Flask(__name__)

# Ruta de la base de datos
db_path = 'datos-api2.db'

# Conexión a la base de datos SQLite
conn = sqlite3.connect(db_path)
cursor = conn.cursor()

# Crear la base de datos y la tabla si no existen
cursor.execute('''
    CREATE TABLE IF NOT EXISTS mediciones (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        temperatura DECIMAL(5, 2) NOT NULL,
        luz INTEGER NOT NULL,
        humedad DECIMAL(5, 2) NOT NULL,
        calidad_aire INTEGER NOT NULL,
        fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    )
''')

conn.commit()
conn.close()

@app.route('/guardar_datos', methods=['POST'])
def enviar_datos():
    if request.method == 'POST':
        # Obtener datos del cuerpo de la solicitud
        data = request.get_json()

        # Verificar si se proporcionan los campos necesarios
        if 'temperatura' in data and 'luz' in data and 'humedad' in data and 'calidad_aire' in data:
            # Conexión a la base de datos SQLite
            conn = sqlite3.connect(db_path)
            cursor = conn.cursor()

            # Insertar datos en la tabla
            cursor.execute('''
                INSERT INTO mediciones (temperatura, luz, humedad, calidad_aire)
                VALUES (?, ?, ?, ?)
            ''', (data['temperatura'], data['luz'], data['humedad'], data['calidad_aire']))

            conn.commit()
            conn.close()

            return jsonify({'mensaje': 'Datos recibidos correctamente'}), 201
        else:
            return jsonify({'error': 'Faltan campos en los datos'}), 400

@app.route('/obtener_datos', methods=['GET'])
def obtener_datos():
    # Consultar datos desde la base de datos
    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()
    cursor.execute('SELECT temperatura, luz, humedad, calidad_aire, fecha FROM mediciones')
    rows = cursor.fetchall()
    conn.close()

    # Formatear los datos para la respuesta JSON
    datos = [{'temperatura': row[0], 'luz': row[1], 'humedad': row[2], 'calidad_aire': row[3], 'fecha': row[4]} for row in rows]

    return jsonify({'datos': datos})

if __name__ == '__main__':
    app.run(debug=True)
