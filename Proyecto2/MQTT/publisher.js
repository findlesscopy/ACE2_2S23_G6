const mqtt = require("mqtt");
//------------------------  arduino ----------------------
const { SerialPort, ReadlineParser } = require("serialport");
const port = new SerialPort({
  path: "COM8",
  baudRate: 9600,
});
const parser = port.pipe(new ReadlineParser({ delimiter: "\n" }));
//------------------------- pub ---------------------
const pub = mqtt.connect("mqtt://localhost:9000");

pub.on("connect", () => {
  parser.on("data", (arduino_data) => {
    arduino_data = arduino_data.toString();
    arduino_data = arduino_data.split(" ");
    topic = arduino_data[0];
    dataSend = arduino_data[1];
    pub.publish(topic, dataSend);
  });
});

//---------------------------------sub----------------------------------------------------

const sub = mqtt.connect("mqtt://localhost:9000");

sub.on("connect", () => {
  sub.subscribe("NotificacionLuz:");
  sub.subscribe("NotificacionAire:");
  sub.subscribe("NotificacionSeguridad:");
});

sub.on("message", (topic, message) => {
  console.log("topic: ", topic, "  msj: ", message.toString());

  // Envía los datos al Arduino a través del puerto serial
  if (port.isOpen) {
      port.write(message.toString(), (err) => {
          if (err) {
              console.error("Error al escribir en el puerto serial:", err);
          } else {
              console.log("Datos enviados al Arduino:", message.toString());
          }
      });
  }
});

port.on("open", () => {
  console.log("Conexión establecida con el puerto serial del Arduino.");
});

port.on("error", (err) => {
  console.error("Error en el puerto serial del Arduino:", err);
});