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
        luz = data['co2']
        humedad = data['luz']
        calidad_aire = data['proximidad']

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

@app.route('/notificacion', methods=['POST'])
def notificacion():
    try:
        data = request.json

        response = data['notificacion']

        if response == 0:
            # enviar la notificación al usuario de que el nivel de CO2 es inadecuado
            return jsonify({"mensaje": "Notificación de calidad del aire es mala enviada correctamente"}), 201
        if response == 1:
            # enviar la notificación al usuario de que el nivel de CO2 es adecuado
            return jsonify({"mensaje": "Notificación de calidad del aire es buena enviada correctamente"}), 201
        if response == 2:
            # enviar la notificación al usuario de que no hay nadie en la habitación y se apagarán las luces
            return jsonify({"mensaje": "Notificación de presencia en habitación enviada correctamente"}), 201
        if response == 3:
            # enviar la notificación al usuario de que se han apagado las luces en la habitación
            return jsonify({"mensaje": "Notificación de luces apagadas enviada correctamente"}), 201
    
    except Exception as e:
        return jsonify({"error": str(e)}), 400

@app.route('/hola', methods=['GET'])
def hola():
    return jsonify({"mensaje": "Hola mundo"}), 200


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
