from flask import Flask, request, jsonify
import sqlite3
from datetime import datetime

app = Flask(__name__)

temperatura_actual = 0
luz_actual = 0
co2_actual = 0
proximidad_actual = 0
estado_luz = 0

# Ruta para almacenar datos
@app.route('/guardar_datos', methods=['POST'])
def guardar_datos():
    try:
        data = request.json

        temperatura = data['temperatura']
        calidad_aire = data['co2']
        luz = data['luz']
        #proximidad = data['proximidad']

        # Conexión a la base de datos SQLite
        conn = sqlite3.connect('data.db')
        cursor = conn.cursor()

        # Crear tabla si no existe
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS prueba (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                temperatura DECIMAL(5, 2) NOT NULL,
                luz INTEGER NOT NULL,
                calidad_aire INTEGER NOT NULL
            )
        ''')

        # Insertar datos en la tabla
        cursor.execute('''
            INSERT INTO prueba (temperatura, luz, calidad_aire)
            VALUES (?, ?, ?)
        ''', (temperatura, luz, calidad_aire))

        conn.commit()
        conn.close()

        return jsonify({"mensaje": "Datos almacenados correctamente"}), 201

    except Exception as e:
        return jsonify({"error": str(e)}), 400

@app.route('/obtener_datos', methods=['GET'])
def obtener_datos():
    
    cadena = ""
    cadena += str(temperatura_actual) + "," + str(luz_actual) + "," + str(co2_actual)

    return cadena

@app.route('/enviar_datos', methods=['POST'])
def enviar_datos():
    try:
        data = request.json

        global temperatura_actual
        nueva_temperatura_actual = data['temperatura']
        temperatura_actual = nueva_temperatura_actual

        global co2_actual
        nuevo_co2_actual = data['co2']
        co2_actual = nuevo_co2_actual

        global luz_actual
        nueva_luz_actual = data['luz']
        luz_actual = nueva_luz_actual

        return jsonify({"mensaje": "Datos actualizados correctamente"}), 201

    except Exception as e:
        return jsonify({"error": str(e)}), 400

@app.route('/estado_luz', methods=['POST'])
def estado_luz():
    try:
        data = request.json

        response = data['estado']

        if response == 0:
            estado_luz = 0
            return "Luces apagadas"
        if response == 1:
            estado_luz = 1
            return "Luces encendidas"
    
    except Exception as e:
        return jsonify({"error": str(e)}), 400 

@app.route('/notificacion', methods=['POST'])
def notificacion():
    try:
        data = request.json
        response = data['notificacion']
        if response == 0:
            # enviar la notificación al usuario de que el nivel de CO2 es inadecuado
            return "Notificación de calidad del aire es mala"
        if response == 1:
            # enviar la notificación al usuario de que el nivel de CO2 es adecuado
            return "Notificación de calidad del aire es buena enviada correctamente"
        if response == 2:
            # enviar la notificación al usuario de que no hay nadie en la habitación y se apagarán las luces
            return "Notificación de presencia en habitación enviada correctamente"
        if response == 3:
            # enviar la notificación al usuario de que se han apagado las luces en la habitación
            return "Notificación de luces apagadas enviada correctamente"
    
    except Exception as e:
        return jsonify({"error": str(e)}), 400

@app.route('/hola', methods=['GET'])
def hola():
    return jsonify({"luz_actual" : luz_actual,"co2_actual": co2_actual,"temperatura_actual": temperatura_actual }), 200


#host = "0.0.0.0"
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
