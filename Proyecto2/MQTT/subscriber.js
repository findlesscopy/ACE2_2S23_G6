const mqtt = require("mqtt");
const sqlite3 = require("sqlite3").verbose();

const db = new sqlite3.Database("data.db");

const sub = mqtt.connect("mqtt://localhost:9000");

sub.on("connect", () => {
    sub.subscribe("Temperatura:");
    sub.subscribe("CO2:");
    sub.subscribe("Luz:");
    sub.subscribe("Distancia:");
});

const insertQuery_create = "CREATE TABLE IF NOT EXISTS mediciones (id INTEGER PRIMARY KEY AUTOINCREMENT, temperatura DECIMAL(5, 2) NOT NULL, luz INTEGER NOT NULL, calidad_aire INTEGER NOT NULL, distancia DECIMAL(5, 2) NOT NULL, fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP)";

db.run(insertQuery_create, function (err) {
    if (err) {
        console.error("Error al crear la tabla SQLite:", err);
    } else {
        console.log("Tabla creada en SQLite.");
    }
});

sub.on("message", (topic, message) => {
    console.log("Topic: ", topic, " msg: ", message.toString());

    // Insertar los datos en la base de datos SQLite
    const insertQuery = "INSERT INTO mediciones (temperatura, luz, calidad_aire, distancia) VALUES (?, ?, ?, ?)";

    let temperatura, luz, calidad_aire, distancia;
    
    if (topic === "Temperatura:") {
        temperatura = message.toString();
    } else if (topic === "Luz:") {
        luz = message.toString();
    } else if (topic === "CalidadAire:") {
        calidad_aire = message.toString();
    } else if (topic === "Distancia:") {
        distancia = message.toString();
    }

    db.run(insertQuery, [temperatura, luz, calidad_aire, distancia], function (err) {
        if (err) {
            console.error("Error al insertar datos en SQLite:", err);
        } else {
            console.log("Datos guardados en SQLite.");
        }
    });
});