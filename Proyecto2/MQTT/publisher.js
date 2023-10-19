const express = require("express");
const app = express();
const port = 5000;
const mqtt = require("mqtt");

const pub = mqtt.connect("mqtt://localhost:9000"); // Reemplaza por la dirección de tu broker MQTT

pub.on("connect", () => {
  console.log("Conectado al servidor MQTT");
  // Suscríbete a los temas MQTT necesarios aquí, si es necesario
  // pub.subscribe("pub");
});

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.post("/publish/temperatura", (req, res) => {
  console.log("Publicando datos de temperatura:", req.body);

  const topic = "sensores/temperatura"; // Tema MQTT para la temperatura
  const message = JSON.stringify(req.body); // Publica los datos en formato JSON

  pub.publish(topic, message, (error) => {
    if (!error) {
      console.log(`Mensaje de temperatura publicado en ${topic}: ${message}`);
      res.send({ message: "Mensaje publicado en MQTT" });
    } else {
      console.error("Error al publicar el mensaje en MQTT:", error);
      res.status(500).send({ error: "Error al publicar el mensaje en MQTT" });
    }
  });
});

app.post("/publish/co2", (req, res) => {
  console.log("Publicando datos de CO2:", req.body);

  const topic = "sensores/co2"; // Tema MQTT para el CO2
  const message = JSON.stringify(req.body);

  pub.publish(topic, message, (error) => {
    if (!error) {
      console.log(`Mensaje de CO2 publicado en ${topic}: ${message}`);
      res.send({ message: "Mensaje publicado en MQTT" });
    } else {
      console.error("Error al publicar el mensaje en MQTT:", error);
      res.status(500).send({ error: "Error al publicar el mensaje en MQTT" });
    }
  });
});

app.post("/publish/luz", (req, res) => {
  console.log("Publicando datos de luz:", req.body);

  const topic = "sensores/luz"; // Tema MQTT para la luz
  const message = JSON.stringify(req.body);

  pub.publish(topic, message, (error) => {
    if (!error) {
      console.log(`Mensaje de luz publicado en ${topic}: ${message}`);
      res.send({ message: "Mensaje publicado en MQTT" });
    } else {
      console.error("Error al publicar el mensaje en MQTT:", error);
      res.status(500).send({ error: "Error al publicar el mensaje en MQTT" });
    }
  });
});

app.listen(port, () => {
  console.log(`Servidor Express escuchando en el puerto ${port}`);
});