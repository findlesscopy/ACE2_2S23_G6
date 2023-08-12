import processing.serial.*;
import processing.data.*;
import http.requests.*;


Serial puerto;
float thermometerHeight = 180; // Altura total del termómetro
float mercuryHeight; // Altura del mercurio
float fixedTemperature = 31; // Temperatura fija en grados Celsius

ArrayList<String[]> listaDeDatos = new ArrayList<String[]>();

float sunlightIntensity = 0.6; // Intensidad de luz solar (0.0 a 1.0)
float minSunRadius = 30; // Radio mínimo del sol
float maxSunRadius = 100; // Radio máximo del sol

float sunRadius; // Radio actual del sol

float airQuality = 0.8; // Calidad del aire (0.0 a 1.0)

float humedad = 75;

//boton
  PApplet newWindow;
  int buttonWidth = 150;
  int buttonHeight = 30;
  int buttonX = 325;
  int buttonY = height + 460;
  boolean btn_pressed = false;

  //data historica
int[] data = {50, 80, 120}; // Datos de las barras
float[] dataTemperatura = new float[3];
float[] dataLux  = new float[3];
float[] dataCo2  = new float[3];
float[] dataHumedad  = new float[3];

float barWidth; // Ancho de cada barra
int maxValue; // Valor máximo en los datos

void setup() {
  size(800, 600);
  mercuryHeight = map(fixedTemperature, 0, 35, 0, thermometerHeight);
  sunRadius = map(sunlightIntensity, 0, 1, minSunRadius, maxSunRadius);
  println(Serial.list()[0]);
  
  puerto = new Serial(this, Serial.list()[0], 9600);
  
  puerto.bufferUntil('\n') ;
  newWindow = new SecondApplet();
}

void draw() {
  background(255); // Fondo blanco
  prueba();
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
  if(humedad < 33) fill(173, 219, 230); // Color azul
  if(humedad >= 33 && humedad <= 66 ) fill(135, 206, 235); // Color azul
  if(humedad >66 ) fill(70, 130, 180); // Color azul
  
  
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

  
  fill(100);
  rect(buttonX, buttonY, buttonWidth, buttonHeight);
  fill(255);
  textAlign(CENTER, CENTER);
  text("Datos Históricos", buttonX + buttonWidth / 2, buttonY + buttonHeight / 2);
}

void serialEvent(Serial puerto) {
  String dato = puerto.readStringUntil('\n');
  
  if (dato != null) {
    String[] datos = dato.split(",");
    listaDeDatos.add(datos); // Agregamos el arreglo a la lista
    //print("hola" + listaDeDatos.get(listaDeDatos.size() - 1)[0]);
    
    // Imprimimos la lista de arreglos
    for (int i = 0; i < listaDeDatos.size(); i++) {
      String[] arreglo = listaDeDatos.get(i);
      fixedTemperature = Float.parseFloat(arreglo[0]);
      airQuality = Float.parseFloat(arreglo[1]);
      humedad = Float.parseFloat(arreglo[2])*100;
      sunlightIntensity = Float.parseFloat(arreglo[3])/1000;
      airQuality = Float.parseFloat(arreglo[1]);
      
      JSONObject json = new JSONObject();
      json.setFloat("temperatura", fixedTemperature);
      json.setFloat("luz", sunlightIntensity * 10000); // Escalamos la intensidad de luz
      json.setFloat("humedad", humedad);
      json.setFloat("calidad_aire", airQuality);
      
      PostRequest post = new PostRequest("http://localhost:5000/guardar_datos");
      post.addHeader("Content-Type", "application/json");
      post.addData(json.toString());
      post.send();
      
      println("Reponse Content: " + post.getContent());
      println("Reponse Content-Length Header: " + post.getHeader("Content-Length"));
    
          //sunlightIntensity = Float.parseFloat(arreglo[3])/10;
      print("Arreglo " + (i+1) + ": ");
      for (int j = 0; j < arreglo.length; j++) {
        print(arreglo[j] + " ");
      }
      println();
    }
  }
}

void prueba(){
  GetRequest get = new GetRequest("http://localhost:5000/obtener_promedios");
      get.addHeader("Accept", "application/json");
      get.send();
      
      String jsonString = get.getContent();
      
      if(jsonString != null){
          JSONArray data = JSONArray.parse(jsonString);
          
          for (int k = 0; k < data.size(); k++) {
            JSONObject entry = data.getJSONObject(k);
            //String fecha = entry.getString("fecha");
            float promedioCalidadAire = entry.getFloat("promedio_calidad_aire");
            float promedioHumedad = entry.getFloat("promedio_humedad");
            float promedioLuz = entry.getFloat("promedio_luz");
            float promedioTemperatura = entry.getFloat("promedio_temperatura");


            dataTemperatura[k] = promedioTemperatura;
            dataLux[k]  = promedioLuz / 1000;
            dataCo2[k]  = promedioCalidadAire;
            dataHumedad[k]  = promedioHumedad;
            /*
            // Aquí puedes guardar los valores en variables o hacer lo que necesites con ellos
            println("Fecha: " + fecha);
            println("Promedio Calidad Aire: " + promedioCalidadAire);
            println("Promedio Humedad: " + promedioHumedad);
            println("Promedio Luz: " + promedioLuz);
            println("Promedio Temperatura: " + promedioTemperatura);
            println("---------");*/
          }
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

void mousePressed() {
  prueba();
  // Verificar si el clic está dentro de los límites del botón
  if (mouseX > buttonX && mouseX < buttonX + buttonWidth && mouseY > buttonY && mouseY < buttonY + buttonHeight) {
      //newWindow = new SecondApplet(); // Marcar que se ha hecho clic en el botón
      String[] args = {"TwoFrameTest"};
      SecondApplet sa = new SecondApplet();
      PApplet.runSketch(args, sa);
  }
}


// Clase para la nueva ventana
public class SecondApplet extends PApplet {

  public void settings() {
    size(800, 600);
  }

  public void draw() {
    background(255);
    fill(0);
    ellipse(100, 50, 10, 10);
    
    float boxWidth = width / 2.0;
    float boxHeight = (height / 2.0);
    
    barWidth = boxWidth / data.length;
    maxValue = max(data);
  
    fill(255);
    rect(0, 0, boxWidth, boxHeight);
    
    fill(255);
    rect(0, 0, boxWidth, boxHeight);
    drawBarChart(dataTemperatura,"Histórico de Temperatura", 0, 0, boxWidth, boxHeight);
    
    fill(255);
    rect(boxWidth, 0, boxWidth, boxHeight);
    drawBarChart(dataLux, "Histórico de Cantidad de Luz", boxWidth, 0 , boxWidth, boxHeight);
    
    fill(255);
    rect(0, boxHeight, boxWidth, boxHeight);
    drawBarChart(dataCo2, "Histórico de Calidad de Aire", 0, boxHeight , boxWidth, boxHeight);
    
    fill(255);
    rect(boxWidth, boxHeight, boxWidth, boxHeight);
    drawBarChart(dataHumedad, "Historico de % Humedad", boxWidth, boxHeight , boxWidth, boxHeight);
  }
  
  void drawBarChart(float[] data, String title, float x, float y, float w, float h) {
  textAlign(CENTER);
  textSize(16);
  fill(0);
  text(title, x + w / 2, y + 20);
  
  for (int i = 0; i < data.length; i++) {
    float barHeight = map(data[i], 0, maxValue, 0, h - 40); // Ajuste de altura

    fill(0, 150, 200);
    rect(x + i * barWidth, y + h - barHeight, barWidth - 10, barHeight); // Ajuste de grosor

    fill(0);
    textAlign(CENTER);
    text(data[i], x + i * barWidth + barWidth / 2, y + h - barHeight - 10);
  }
}




}
