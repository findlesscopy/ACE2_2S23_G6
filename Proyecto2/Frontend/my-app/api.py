from flask import Flask, request, jsonify

app = Flask(__name__)

# Lista para almacenar los datos
datos = []

@app.route('/enviar_datos', methods=['POST'])
def enviar_datos():
    if request.method == 'POST':
        # Obtener datos del cuerpo de la solicitud
        data = request.get_json()

        # Verificar si se proporcionan los campos necesarios
        if 'temperatura' in data and 'luz' in data and 'humedad' in data and 'calidad_aire' in data:
            # Guardar los datos en la lista
            datos.append(data)
            
            return jsonify({'mensaje': 'Datos recibidos correctamente'}), 201
        else:
            return jsonify({'error': 'Faltan campos en los datos'}), 400

@app.route('/obtener_datos', methods=['GET'])
def obtener_datos():
    return jsonify({'datos': datos})

if __name__ == '__main__':
    app.run(debug=True)
