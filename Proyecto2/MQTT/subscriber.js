const mqtt = require("mqtt");
const mysql = require("mysql");
let get = true;
const Topic = "Temperatura:";

const sub = mqtt.connect("mqtt://localhost:9000");

sub.on("connect", () => {
    sub.subscribe(Topic);
});

sub.on("message", (topic, message) => {
    console.log("Topic: ", topic, " msg: ", message.toString());
});

