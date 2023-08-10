import processing.serial.*;
Serial puerto;
float thermometerHeight = 180; // Altura total del termómetro
float mercuryHeight; // Altura del mercurio
float fixedTemperature = 13; // Temperatura fija en grados Celsius

float sunlightIntensity = 0.7; // Intensidad de luz solar (0.0 a 1.0)
float minSunRadius = 30; // Radio mínimo del sol
float maxSunRadius = 100; // Radio máximo del sol

float sunRadius; // Radio actual del sol

float airQuality = 0.79; // Calidad del aire (0.0 a 1.0)

float humedad = 0;

void setup() {
  size(800, 600);
  mercuryHeight = map(fixedTemperature, 0, 35, 0, thermometerHeight);
  sunRadius = map(sunlightIntensity, 0, 1, minSunRadius, maxSunRadius);
  println(Serial.list()[0]);
  
  puerto = new Serial(this, Serial.list()[0], 9600);
  
  puerto.bufferUntil('\n') ;
  
}

void draw() {
  background(255); // Fondo blanco

  // Tamaño de cada recuadro
  float boxWidth = width / 2.0;
  float boxHeight = (height / 2.0) - 60;

  fill(255);
  rect(0, 0, boxWidth, boxHeight);

  drawTermo(boxWidth / 2, boxHeight - 50);
  
  stroke(0);


  // Resto del código para los otros recuadros y el botón
  fill(255); // Color verde
  rect(boxWidth, 0, boxWidth, boxHeight);
  
  // Dibujar sol en el segundo recuadro superior
  float sunCenterX = boxWidth + boxWidth / 2;
  float sunCenterY = boxHeight / 2;


  fill(255, 255, 0); // Color amarillo para el sol
  stroke(0);
  ellipse(sunCenterX, sunCenterY, sunRadius * 2, sunRadius * 2);
    
   // Actualizar el radio del sol con una animación suave


   float targetSunRadius = map(sunlightIntensity, 0, 1, minSunRadius, maxSunRadius);
   sunRadius = lerp(sunRadius, targetSunRadius, 0.05);

  textSize(18);
  textAlign(CENTER, BOTTOM);
  fill(0);
  text("Cantidad de Luz Solar: " + int(sunlightIntensity*100) + " Lumen", sunCenterX, sunCenterY + 120);
  
  fill(255); // Color azul
  rect(0, boxHeight, boxWidth, boxHeight);
  drawCloud(boxWidth/2,boxHeight + boxHeight /3 , 100);
  
  stroke(0);
  
  fill(255); // Color blanco
  rect(boxWidth, boxHeight, boxWidth, boxHeight);
   float x = boxWidth + boxWidth / 2;
  float y = boxHeight + boxHeight / 2 + 20;
  float dropWidthBig = 450; // Ancho de la gota más grande
  float dropHeight = 200; // Altura de las gotas

    // Círculo en la parte inferior
  float circleRadius = 100;
  fill(255);
  stroke(0);
  ellipse(x, y-30, circleRadius * 2, circleRadius * 2);
  
  // Gota grande (en medio)
  fill(0, 0, 255); // Color azul
  drawDrop(x-50, y, dropWidthBig-50, dropHeight-50);
  drawDrop(x+50, y, dropWidthBig-50, dropHeight-50);
  drawDrop(x, y, dropWidthBig, dropHeight);

  // Texto de temperatura fija
  textSize(18);
  textAlign(CENTER, BOTTOM);
  fill(0);
  text("% de Humedad: " + int(humedad) + " %", x, y + 100);

  
  // Texto en la parte inferior
  textSize(16);
  textAlign(CENTER, BOTTOM);
  fill(0);
  text("Estación meteorológica IOT", width / 2, height - 50);

  int buttonWidth = 150;
  int buttonHeight = 30;
  int buttonX = width / 2 - buttonWidth / 2;
  int buttonY = height - 40;
  fill(100);
  rect(buttonX, buttonY, buttonWidth, buttonHeight);
  fill(255);
  textAlign(CENTER, CENTER);
  text("Datos Históricos", buttonX + buttonWidth / 2, buttonY + buttonHeight / 2);
}

void serialEvent(Serial puerto){
  String dato= puerto.readStringUntil('\n');
  if(dato != null){
    print(dato);
  }
}

void drawCloud(float x, float y, float size) {
  noStroke(); // Sin borde
  if(airQuality <= 0.35)fill(220);
  else if(airQuality > 0.35 && airQuality <= 0.75) fill(150);
  else if(airQuality >= 0.75 ) fill(80);
  
  ellipse(x, y, size, size); // Círculo central
  
  ellipse(x - size * 0.5, y, size * 0.8, size * 0.8); // Círculo izquierdo
  ellipse(x + size * 0.5, y, size * 0.8, size * 0.8); // Círculo derecho
  
  ellipse(x, y + size * 0.4, size * 0.8, size * 0.8); // Círculo inferior
  
  ellipse(x - size * 0.35, y + size * 0.4, size * 0.8, size * 0.8); // Círculo inferior izquierdo
  ellipse(x + size * 0.35, y + size * 0.4, size * 0.8, size * 0.8); // Círculo inferior derecho
  
  // Texto de temperatura fija
  textSize(18);
  textAlign(CENTER, BOTTOM);
  fill(0);
  text("Calidad de aire: " + int(airQuality) + " ppm", x, y + 140);
}

void drawTermo(float x, float y){
    // Cambio de color del mercurio en función de la temperatura
  color mercuryColor = color(255, 72, 8);
  if (fixedTemperature < 15) {
    mercuryColor = color(25, 73, 227); // Azul para temperaturas bajas
  } else if (fixedTemperature >= 15 && fixedTemperature <= 20){
    mercuryColor = color(74, 255, 200);  
  } else if (fixedTemperature > 20 && fixedTemperature < 25){
    mercuryColor = color(255, 206, 40); // Verde por defecto
  } else if (fixedTemperature >= 25 && fixedTemperature <= 30) {
    mercuryColor = color(255, 134, 4); // Verde por defecto
  }

  fill(200);
  stroke(0);
  rect(x - 10, y - thermometerHeight, 20, thermometerHeight, 20, 20, 0, 0);

  float circleRadius = 15;
  fill(mercuryColor);
  stroke(0);
  ellipse(x, y, circleRadius * 2, circleRadius * 2);
  
  fill(mercuryColor);
  noStroke();
  rect(x - 10, y - mercuryHeight, 20, mercuryHeight, 20, 20, 0, 0);
   


    // Texto de temperatura fija
  textSize(18);
  textAlign(CENTER, BOTTOM);
  fill(0);
  text("Temperatura: " + int(fixedTemperature) + "°C", x, y + 40);
}

void drawDrop(float x, float y, float width, float height) {
  beginShape();
  vertex(x, y - height * 0.5);
  bezierVertex(x + width * 0.3, y + height * 0.3,
               x - width * 0.3, y + height * 0.3,
               x, y - height * 0.5);
  endShape(CLOSE);
}
