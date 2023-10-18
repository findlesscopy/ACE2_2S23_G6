#include <DHT.h>
#include <MQ135.h>
#include <Servo.h>

#define DHTPIN 2      // El número del pin digital al que está conectado el sensor DHT11
#define DHTTYPE DHT11  // Tipo del sensor (DHT11 o DHT22)
#define ANALOG_PIN 0  // Pin analógico al que está conectado el MQ-135
#define LDR_PIN A1    // Pin analógico al que está conectado el sensor LDR
#define FAN_PIN 11     // Pin al que está conectado el ventilador
#define LED_PIN 6     // Pin al que está conectado el LED
#define TRIG_PIN 8    // Pin al que está conectado el pin TRIG del sensor ultrasónico
#define ECHO_PIN 9    // Pin al que está conectado el pin ECHO del sensor ultrasónico
#define SERVO_PIN 3   // Pin para el servomotor

DHT dht(DHTPIN, DHTTYPE);
MQ135 gasSensor = MQ135(ANALOG_PIN);
Servo myServo;

// Variables para el sensor ultrasónico
long duration;
int distance;

char valor_dato = '0';  // Inicializar valor_dato como '0'

unsigned long time_now = 0;
int period = 1000;

void setup() {
  Serial.begin(9600);
  dht.begin();
  pinMode(FAN_PIN, OUTPUT);   // Configurar el pin del ventilador como salida
  pinMode(LED_PIN, OUTPUT);   // Configurar el pin del LED como salida
  pinMode(TRIG_PIN, OUTPUT); // Configurar el pin TRIG como salida
  pinMode(ECHO_PIN, INPUT);  // Configurar el pin ECHO como entrada
  myServo.attach(SERVO_PIN);  // Adjuntar el servo al pin SERVO_PIN
  time_now = millis();
}

void loop() {

  /// Leer temperatura del sensor DHT11
  float tempC = dht.readTemperature();

  // Leer concentración de CO2 del sensor MQ-135
  float ppm = gasSensor.getPPM();

  // Realizar una medición de proximidad con el sensor ultrasónico
  digitalWrite(TRIG_PIN, LOW);
  delayMicroseconds(2);
  digitalWrite(TRIG_PIN, HIGH);
  delayMicroseconds(10);
  digitalWrite(TRIG_PIN, LOW);
  duration = pulseIn(ECHO_PIN, HIGH);
  distance = duration * 0.034 / 2; // Calcular la distancia en centímetros

  // Leer valor del sensor LDR
  int ldrValue = analogRead(LDR_PIN);
  
  if (millis() >= time_now + period){
    time_now += period;
    Serial.print("Temperatura: ");
    Serial.println(tempC);
  }
}
