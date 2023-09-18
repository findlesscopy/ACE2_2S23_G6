#include <ESP8266WiFi.h>
#include <WiFiClient.h>
#include <DHT.h>
#include <MQ135.h>
#include <ArduinoJson.h>

#define DHTPIN 2      // El número del pin digital al que está conectado el sensor DHT11
#define DHTTYPE DHT11  // Tipo del sensor (DHT11 o DHT22)
#define ANALOG_PIN 0  // Pin analógico al que está conectado el MQ-135
#define LDR_PIN A0    // Pin analógico al que está conectado el sensor LDR

const char* ssid = "Tu_SSID";            // Nombre de tu red WiFi
const char* password = "Tu_Contraseña";  // Contraseña de tu red WiFi
const char* server = "http://127.0.0.1";  // Dirección de la API
const int port = 5000;                     // Puerto HTTP (generalmente 80)

float temperatura, co2, proximidad;
int luz, notificacion;
bool presencia;

int estadoLuz, estadoTemperatura; // 0 = apagada, 1 = encendida
int velocidadVentilador; // 0 = baja , 1 = alta

DHT dht(DHTPIN, DHTTYPE);
MQ135 gasSensor = MQ135(ANALOG_PIN);

void setup() {
  Serial.begin(115200);
  delay(10);

  // Conectar a la red WiFi
  WiFi.begin(ssid, password);

  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
    Serial.println("Conectando a WiFi...");
  }

  Serial.println("Conexión WiFi establecida");
}

void loop() {

  // Leer temperatura
  temperatura = dht.readTemperature();
  
  // Leer concentración de CO2 del sensor MQ-135
  co2 = gasSensor.getPPM();

  // Leer valor del sensor LDR
  luz = analogRead(LDR_PIN);

  // TODO: Leer valor del sensor de proximidad
  if (WiFi.status() == WL_CONNECTED) {
    // Crear un objeto WiFiClient para la comunicación
    WiFiClient client;

    // Conectar al servidor
    if (client.connect(server, port)) {
      Serial.println("Conectado al servidor");

        // Analiza todos los datos que recibe de la APP (Luz y Temperatura)
        gestorReceptor();

        // Enviar datos a la API
        enviarDatosAPI();

        // Enviar datos a la BD
        enviarDatosBD();

        // verificar si la calidad del aire es buena
        sistemaVentilacion();

        // verificar si hay alguien en la habitación
        sistemaIluminacion();

  
      // Leer y mostrar la respuesta del servidor
      while (client.available()) {
        String line = client.readStringUntil('\r');
        Serial.print(line);
      }
    } else {
      Serial.println("Error al conectar al servidor");
    }

    client.stop();
  }
  delay(10000); // Esperar un minuto antes de enviar otra solicitud
}

void sistemaVentilacion(){
  if(co2 > 1000){
    // iniciar un temporizador de 30 segundos
    delay(30000);

    // enviar notificacion de calidad del aire mala a app
    notificacion = 0;
    enviarNotificacion();

    // iniciar un temporizador de 30 segundos
    delay(30000);

    // encender ventilador por 30 segundos

    
    // enviar notificacion de calidad del aire buena a app
    notificacion = 1;
    enviarNotificacion();

  }
}

void sistemaIluminacion(){
  if(!presencia){
    // inicia un temporizador de 30 segundos
    delay(30000);

    // enviar notificacion de que no hay nadie a la app
    notificacion = 2;
    enviarNotificacion();
    // inicia un temporizador de 30 segundos
    delay(30000);

    // apagar luces

    // enviar notificacion de que se ha apagado la luz en la habitación
    notificacion = 3;
    enviarNotificacion();
  }
}

void enviarDatos(){

      DynamicJsonDocument jsonBuffer(1024);

      jsonBuffer["temperatura"] = temperatura;
      jsonBuffer["co2"] = co2;
      jsonBuffer["luz"] = luz;
      jsonBuffer["proximidad"] = 0;

      String jsonData;
      serializeJson(jsonBuffer, jsonData);
      // Realizar una solicitud POST a la API con JSON
      client.println("POST /guardar_datos HTTP/1.1");
      client.println("Host: " + String(server));
      client.println("Content-Type: application/json");
      client.println("Content-Length: " + String(jsonData.length()));
      client.println();
      client.println(jsonData);

      delay(500);

}

void enviarNotificacion(){

      DynamicJsonDocument jsonBuffer(1024);

      jsonBuffer["notificacion"] = notificacion; 
      // 0 = calidad del aire mala
      // 1 = calidad del aire es buena
      // 2 = no hay nadie en la habitación
      // 3 = se ha apagado la luz en la habitación

      // Serializar el objeto JSON a una cadena
      String jsonData;
      serializeJson(jsonBuffer, jsonData);

      // Realizar una solicitud POST a la API con JSON
      client.println("POST /notificacion HTTP/1.1");
      client.println("Host: " + String(server));
      client.println("Content-Type: application/json");
      client.println("Content-Length: " + String(jsonData.length()));
      client.println();
      client.println(jsonData);

      delay(500);

}

void enviarDatosBD(){

      DynamicJsonDocument jsonBuffer(1024);

      jsonBuffer["temperatura"] = temperatura;
      jsonBuffer["co2"] = co2;
      jsonBuffer["luz"] = luz;
      jsonBuffer["proximidad"] = 0;

      String jsonData;
      serializeJson(jsonBuffer, jsonData);
      // Realizar una solicitud POST a la API con JSON
      client.println("POST /guardar_datos HTTP/1.1");
      client.println("Host: " + String(server));
      client.println("Content-Type: application/json");
      client.println("Content-Length: " + String(jsonData.length()));
      client.println();
      client.println(jsonData);

      delay(500);

}

void enviarDatosAPI(){

      DynamicJsonDocument jsonBuffer(1024);

      jsonBuffer["temperatura"] = temperatura;
      jsonBuffer["co2"] = co2;
      jsonBuffer["luz"] = luz;
      jsonBuffer["proximidad"] = 0;

      String jsonData;
      serializeJson(jsonBuffer, jsonData);

      // Realizar una solicitud POST a la API con JSON
      client.println("POST /enviar_datos HTTP/1.1");
      client.println("Host: " + String(server));
      client.println("Content-Type: application/json");
      client.println("Content-Length: " + String(jsonData.length()));
      client.println();
      client.println(jsonData);

      delay(500);
}

int recibirDatosSistemaLuz(){
  if(WiFi.status() == WL_CONNECTED){

    WiFiClient client;

    if(client.connect(server, port)){
      Serial.println("Conectado al servidor");

      client.println("GET /enviar_estado_luz HTTP/1.1");  // Reemplaza /ruta_de_tu_recurso con la ruta real
      client.println("Host: " + String(server));
      client.println("Connection: close");
      client.println();

      String respuestaJson = "";

      while (client.connected()) {
        if(client.available()){
          char c = client.read();
          respuestaJson += c;
        }
      }

      client.stop();
      Serial.println("Conexión cerrada");

      DynamicJsonDocument jsonBuffer(1024);
      DeserializationError error = deserializeJson(jsonBuffer, respuestaJson);

      if(error){
        Serial.println("Error al analizar el JSON");
        Serial.println(error.c_str());
        return 0;
      } else {
        estadoLuz = jsonBuffer["estado_luz"];
        Serial.println("Estado de la luz: " + estadoLuz);
      }
    } else {
      Serial.println("Error al conectar al servidor");
    }
  }
  return estadoLuz;
}

int recibirDatosSistemaVentilacion(){
  if(WiFi.status() == WL_CONNECTED){

    WiFiClient client;

    if(client.connect(server, port)){
      Serial.println("Conectado al servidor");

      client.println("GET /enviar_estado_temperatura HTTP/1.1");  // Reemplaza /ruta_de_tu_recurso con la ruta real
      client.println("Host: " + String(server));
      client.println("Connection: close");
      client.println();

      String respuestaJson = "";

      while (client.connected()) {
        if(client.available()){
          char c = client.read();
          respuestaJson += c;
        }
      }

      client.stop();
      Serial.println("Conexión cerrada");

      DynamicJsonDocument jsonBuffer(1024);
      DeserializationError error = deserializeJson(jsonBuffer, respuestaJson);

      if(error){
        Serial.println("Error al analizar el JSON");
        Serial.println(error.c_str());
        return 0;
      } else {
        estadoTemperatura = jsonBuffer["estado_temperatura"];
        Serial.println("Estado de la temperatura: " + estadoTemperatura);
      }
    } else {
      Serial.println("Error al conectar al servidor");
    }
  }
  return estadoTemperatura;
}

int recibirVelocidadVentilador(){
  if(WiFi.status() == WL_CONNECTED){

    WiFiClient client;

    if(client.connect(server, port)){
      Serial.println("Conectado al servidor");

      client.println("GET /enviar_velocidad_ventilador HTTP/1.1");  // Reemplaza /ruta_de_tu_recurso con la ruta real
      client.println("Host: " + String(server));
      client.println("Connection: close");
      client.println();

      String respuestaJson = "";

      while (client.connected()) {
        if(client.available()){
          char c = client.read();
          respuestaJson += c;
        }
      }

      client.stop();
      Serial.println("Conexión cerrada");

      DynamicJsonDocument jsonBuffer(1024);
      DeserializationError error = deserializeJson(jsonBuffer, respuestaJson);

      if(error){
        Serial.println("Error al analizar el JSON");
        Serial.println(error.c_str());
        return 0;
      } else {
        velocidadVentilador = jsonBuffer["velocidad_ventilador"];
        Serial.println("Velocidad de ventilador: " + velocidadVentilador);
      }
    } else {
      Serial.println("Error al conectar al servidor");
    }
  }
  return velocidadVentilador;
}

void gestorReceptor(){

  if(recibirDatosSistemaLuz() == 1){
    // encender luz
    //TODO: realizar codigo de encender luz
    estadoLuz = 1;
  } else if(recibirDatosSistemaLuz() == 0){
    // apagar luz
    //TODO: realizar codigo de apagar luz
    estadoLuz = 0;
  }

  if(recibirDatosSistemaVentilacion() == 1){
    // encender ventilador
    if(recibirVelocidadVentilador() == 1){
      // velocidad alta
      // TODO: realizar codigo de encender ventilador en velocidad alta
    } else if(recibirVelocidadVentilador() == 0){
      // velocidad baja
      // TODO: realizar codigo de encender ventilador en velocidad baja
    }
  }

}