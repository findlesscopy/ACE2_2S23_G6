#include <ESP8266WiFi.h>
#include <WiFiClient.h>
#include <DHT.h>
#include <MQ135.h>
#include <ArduinoJson.h>

#define DHTPIN 2      // El número del pin digital al que está conectado el sensor DHT11
#define DHTTYPE DHT11  // Tipo del sensor (DHT11 o DHT22)
#define ANALOG_PIN 0  // Pin analógico al que está conectado el MQ-135
#define LDR_PIN A1    // Pin analógico al que está conectado el sensor LDR

const char* ssid = "Tu_SSID";            // Nombre de tu red WiFi
const char* password = "Tu_Contraseña";  // Contraseña de tu red WiFi
const char* server = "http://127.0.0.1";  // Dirección de la API
const int port = 5000;                     // Puerto HTTP (generalmente 80)

float temperatura, co2, proximidad;
int luz, notificacion;
bool presencia;

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



  // Enviar datos a la API
  enviarDatos();

  // verificar si la calidad del aire es buena
  sistemaVentilacion();

  // verificar si hay alguien en la habitación
  sistemaIluminacion();

  
  delay(60000); // Esperar un minuto antes de enviar otra solicitud
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

  if (WiFi.status() == WL_CONNECTED) {
    // Crear un objeto WiFiClient para la comunicación
    WiFiClient client;

    // Conectar al servidor
    if (client.connect(server, port)) {
      Serial.println("Conectado al servidor");

      DynamicJsonDocument jsonBuffer(1024);

      jsonDocument["temperatura"] = temperatura;
      jsonDocument["co2"] = co2;
      jsonDocument["luz"] = luz;
      jsonDocument["proximidad"] = 0;



      // Realizar una solicitud POST a la API con JSON
      client.println("POST /guardar_datos HTTP/1.1");
      client.println("Host: " + String(server));
      client.println("Content-Type: application/json");
      client.println("Content-Length: " + String(jsonData.length()));
      client.println();
      client.println(jsonData);

      delay(500);

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

}

void enviarNotificacion(){

  if (WiFi.status() == WL_CONNECTED) {
    // Crear un objeto WiFiClient para la comunicación
    WiFiClient client;

    // Conectar al servidor
    if (client.connect(server, port)) {
      Serial.println("Conectado al servidor");

      DynamicJsonDocument jsonBuffer(1024);

      jsonDocument["notificacion"] = notificacion; 
      // 0 = calidad del aire mala
      // 1 = calidad del aire es buena
      // 2 = no hay nadie en la habitación
      // 3 = se ha apagado la luz en la habitación

      // Serializar el objeto JSON a una cadena
      String jsonData;
      serializeJson(jsonDocument, jsonData);

      // Realizar una solicitud POST a la API con JSON
      client.println("POST /notificacion HTTP/1.1");
      client.println("Host: " + String(server));
      client.println("Content-Type: application/json");
      client.println("Content-Length: " + String(jsonData.length()));
      client.println();
      client.println(jsonData);

      delay(500);

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
}