PImage solImg, nubesImg, solNubesImg;
int temperatura = 10; // Temperatura inicial (puedes cambiarla según necesites)

void setup() {
  size(400, 400);
  solImg = loadImage("sol.png");
  nubesImg = loadImage("nubes.jpg");
  solNubesImg = loadImage("solnubes.png");
}

void draw() {
  background(255);
  
  // Verificar la temperatura y mostrar la imagen correspondiente
  if (temperatura > 25) {
    image(solImg, 0, 0, width, height);
  } else if (temperatura < 15) {
    image(nubesImg, 0, 0, width, height);
  } else {
    
    image(solNubesImg, 0, 0, width, height);
  }
  
  // Mostrar el valor de la temperatura en la esquina superior izquierda
  fill(0);
  textSize(20);
  text("Temperatura: " + temperatura + "°C", 10, 30);
}

// Interactuar con el mouse para cambiar la temperatura
void mousePressed() {
  // Incrementar la temperatura cuando se hace clic en el lado derecho de la pantalla
  if (mouseX > width / 2) {
    temperatura++;
  }
  
  // Decrementar la temperatura cuando se hace clic en el lado izquierdo de la pantalla
  if (mouseX < width / 2) {
    temperatura--;
  }
}
