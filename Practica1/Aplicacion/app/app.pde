void setup() {
  size(800, 600, P2D);
}

void draw() {
  background(255); // Fondo blanco
  
  float boxWidth = width / 2.0; 
  float boxHeight = height / 2.0; 

  fill(255, 0, 0); // Color rojo
  rect(0, 0, boxWidth, boxHeight);

  fill(0, 255, 0); // Color verde
  rect(boxWidth, 0, boxWidth, boxHeight);

  fill(0, 0, 255); // Color azul
  rect(0, boxHeight, boxWidth, boxHeight);

  fill(255); // Color blanco
  rect(boxWidth, boxHeight, boxWidth, boxHeight);
}
