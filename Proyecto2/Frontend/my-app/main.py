from flask import Flask, request, jsonify
import sqlite3
from datetime import datetime

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

        # Conexión a la base de datos SQLite
        conn = sqlite3.connect('datos.db')
        cursor = conn.cursor()

        # Crear tabla si no existe
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


@app.route('/obtener_promedios', methods=['GET'])
def obtener_promedios():
    try:
        # Conexión a la base de datos SQLite
        conn = sqlite3.connect('datos.db')
        cursor = conn.cursor()

        # Obtener promedios de datos agrupados por fecha
        cursor.execute('''
            SELECT DATE(fecha),
                   AVG(temperatura),
                   AVG(luz),
                   AVG(humedad),
                   AVG(calidad_aire)
            FROM mediciones
            GROUP BY DATE(fecha)
        ''')

        datos_promedio = cursor.fetchall()

        conn.close()

        # Crear una lista de diccionarios para el resultado
        resultados = []
        for dato in datos_promedio:
            resultado = {
                "fecha": dato[0],
                "promedio_temperatura": dato[1],
                "promedio_luz": dato[2],
                "promedio_humedad": dato[3],
                "promedio_calidad_aire": dato[4]
            }
            resultados.append(resultado)

        return jsonify(resultados), 200

    except Exception as e:
        return jsonify({"error": str(e)}), 400

if __name__ == '__main__':
    app.run(debug=True)