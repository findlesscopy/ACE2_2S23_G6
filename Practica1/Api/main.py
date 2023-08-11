from flask import Flask, request, jsonify
import sqlite3

app = Flask(__name__)

# Ruta para almacenar datos
@app.route('/guardar_datos', methods=['POST'])
def guardar_datos():
    try:
        data = request.json

        temperatura = data['temperatura']
        luz = data['luz']
        humedad = data['humedad']
        calidad_aire = data['calidad_aire']

        # ConexiÃ³n a la base de datos SQLite
        conn = sqlite3.connect('datos.db')
        cursor = conn.cursor()

        # Crear tabla si no existe
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS mediciones (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                temperatura DECIMAL(5, 2) NOT NULL,
                luz INTEGER    luz INT NOT NULL,
                humedad DECIMAL(5, 2) NOT NULL,
                calidad_aire INTEGER NOT NULL
            )
        ''')

        # Insertar datos en la tabla
        cursor.execute('''
            INSERT INTO mediciones (temperatura, luz, humedad, calidad_aire)
            VALUES (?, ?, ?, ?)
        ''', (temperatura, luz, humedad, calidad_aire))

        conn.commit()
        conn.close()

        return jsonify({"mensaje": "Datos almacenados correctamente"}), 201

    except Exception as e:
        return jsonify({"error": str(e)}), 400

if __name__ == '__main__':
    app.run(debug=True)