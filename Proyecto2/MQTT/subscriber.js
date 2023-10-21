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

const accumulatedData = {
    temperatura: null,
    luz: null,
    calidad_aire: null,
    distancia: null
};

sub.on("message", (topic, message) => {
    console.log("Topic: ", topic, " msg: ", message.toString());

    if (topic === "Temperatura:") {
        accumulatedData.temperatura = message.toString();
    } else if (topic === "Luz:") {
        accumulatedData.luz = message.toString();
    } else if (topic === "CalidadAire:") {
        accumulatedData.calidad_aire = message.toString();
    } else if (topic === "Distancia:") {
        accumulatedData.distancia = message.toString();
    }

    // Verificar si tenemos todos los datos para realizar la inserción
    if (accumulatedData.temperatura !== null && accumulatedData.luz !== null && accumulatedData.calidad_aire !== null && accumulatedData.distancia !== null) {
        // Insertar los datos en la base de datos SQLite
        const insertQuery = "INSERT INTO mediciones (temperatura, luz, calidad_aire, distancia) VALUES (?, ?, ?, ?)";

        db.run(insertQuery, [accumulatedData.temperatura, accumulatedData.luz, accumulatedData.calidad_aire, accumulatedData.distancia], function (err) {
            if (err) {
                console.error("Error al insertar datos en SQLite:", err);
            } else {
                console.log("Datos guardados en SQLite.");
            }
        });

        // Reiniciar los datos acumulados
        for (const key in accumulatedData) {
            accumulatedData[key] = null;
        }
    }
});