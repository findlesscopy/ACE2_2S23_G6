const mosca = require("mosca");
const port = 9000;

const broker = new mosca.Server({ 
    port: port,
});

broker.on("ready", () => {
    console.log("Broker listo en el puerto: " + port);
});

broker.on("clientConnected", (client) => {
    console.log("(MQTT) Cliente conectado: " + client.id);
});

broker.on("clientDisconnected", function onClientDisconnected(client){
    console.log("(MQTT) Cliente desconectado: " + client.id);
});


