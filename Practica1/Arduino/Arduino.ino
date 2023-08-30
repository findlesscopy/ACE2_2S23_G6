#include <DHT.h>
#include <MQ135.h>

#define DHTPIN 2      // El número del pin digital al que está conectado el sensor DHT11
#define DHTTYPE DHT11  // Tipo del sensor (DHT11 o DHT22)
#define ANALOG_PIN 0  // Pin analógico al que está conectado el MQ-135
#define LDR_PIN A1    // Pin analógico al que está conectado el sensor LDR

DHT dht(DHTPIN, DHTTYPE);
MQ135 gasSensor = MQ135(ANALOG_PIN);

void setup() {
  Serial.begin(9600);
  dht.begin();
}

void loop() {
  delay(5000);  // Esperar 2 segundos entre lecturas

  // Leer temperatura y humedad del sensor DHT11
  float tempC = dht.readTemperature();
  
  // Leer concentración de CO2 del sensor MQ-135
  float ppm = gasSensor.getPPM();

  // Leer valor del sensor LDR
  int ldrValue = analogRead(LDR_PIN);

  // Imprimir los valores
  Serial.print(tempC);
  Serial.print(",");
  Serial.print(humidity);
  Serial.print(",");
  Serial.print(ppm);
  Serial.print(",");
  Serial.println(ldrValue);

}
