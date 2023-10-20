const mqtt = require("mqtt");

const sub = mqtt.connect("mqtt://localhost:9000");

sub.on("connect", () => {
    sub.subscribe("Temperatura:");
    sub.subscribe("CO2:");
    sub.subscribe("Luz:");
    sub.subscribe("Distancia:");
});

sub.on("message", (topic, message) => {
    console.log("Topic: ", topic, " msg: ", message.toString());
});