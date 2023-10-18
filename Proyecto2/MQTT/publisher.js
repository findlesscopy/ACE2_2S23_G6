const mqtt = require("mqtt");
//-----------------------------------------------
//                  ARDUINO
//-----------------------------------------------
const {SerialPort, ReadlineParser} = require("serialport");
const port = new SerialPort({ 
    path: "COM8",
    baudRate: 9600 
});
const parser = port.pipe(new ReadlineParser({ delimiter: "\n" }));
//-----------------------------------------------
//                  PUBLISHER
//-----------------------------------------------
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

port.on("open", () => {
    console.log("Puerto serial abierto");
});

port.on("error", (err) => {
    console.log("Error en la conexion serial: "+err);
});