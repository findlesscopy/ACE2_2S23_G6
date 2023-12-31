const express = require("express");
const app = express();
const port = 5000;
const mqtt = require("mqtt");
const sqlite3 = require("sqlite3").verbose();

const db = new sqlite3.Database("data.db");

const pub = mqtt.connect("mqtt://localhost:9000"); // Reemplaza por la dirección de tu broker MQTT
const db_path = "data.db";

pub.on("connect", () => {
  console.log("Conectado al servidor MQTT");
  // Suscríbete a los temas MQTT necesarios aquí, si es necesario
  // pub.subscribe("pub");
});

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.post("/publish/ventilador", (req, res) => {
  console.log("Publicando solicitud de encender/apagar ventilador:", req.body);

  const topic = "ARQUI2_G6_notificacion_ventilador:"; // Tema MQTT para la temperatura
  const message = JSON.stringify(req.body); // Publica los datos en formato JSON

  pub.publish(topic, message, (error) => {
    if (!error) {
      console.log(`Mensaje de Ventilador publicado en ${topic}: ${message}`);
      res.send({ message: "Mensaje publicado en MQTT" });
    } else {
      console.error("Error al publicar el mensaje en MQTT:", error);
      res.status(500).send({ error: "Error al publicar el mensaje en MQTT" });
    }
  });
});

app.post("/publish/seguridad", (req, res) => {
  console.log("Publicando solicitud de abrir/cerrar puerta:", req.body);

  const topic = "ARQUI2_G6_notificacion_puerta:"; // Tema MQTT para el CO2
  const message = JSON.stringify(req.body);

  pub.publish(topic, message, (error) => {
    if (!error) {
      console.log(`Mensaje de Puerta publicado en ${topic}: ${message}`);
      res.send({ message: "Mensaje publicado en MQTT" });
    } else {
      console.error("Error al publicar el mensaje en MQTT:", error);
      res.status(500).send({ error: "Error al publicar el mensaje en MQTT" });
    }
  });
});

app.post("/publish/lampara", (req, res) => {
  console.log("Publicando solicitud de encender/apagar lampara:", req.body);

  const topic = "ARQUI2_G6_notificacion_lampara:"; // Tema MQTT para la luz
  const message = JSON.stringify(req.body);

  pub.publish(topic, message, (error) => {
    if (!error) {
      console.log(`Mensaje de Lampara publicado en ${topic}: ${message}`);
      res.send({ message: "Mensaje publicado en MQTT" });
    } else {
      console.error("Error al publicar el mensaje en MQTT:", error);
      res.status(500).send({ error: "Error al publicar el mensaje en MQTT" });
    }
  });
});

app.get("/obtener_datos", (req, res) => {
  // Consultar datos desde la base de datos
  const conn = new sqlite3.Database(db_path);

  conn.all("SELECT temperatura, luz, calidad_aire, distancia, fecha FROM mediciones", (err, rows) => {
      if (err) {
          res.status(500).json({ error: "Error al consultar la base de datos" });
          return;
      }

      // Formatear los datos para la respuesta JSON
      const datos = rows.map(row => ({
          temperatura: row.temperatura,
          luz: row.luz,
          calidad_aire: row.calidad_aire,
          distancia: row.distancia,
          fecha: row.fecha
      }));

      res.json({ datos });
  });

  conn.close();
});


app.listen(port, () => {
  console.log(`Servidor Express escuchando en el puerto ${port}`);
});