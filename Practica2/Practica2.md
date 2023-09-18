## Control Climático en alcobas Inteligentes a través del Análisis Meteorológico IoT.

## Integrantes

| Nombre                       | Carnet    |
| ---------------------------- | --------- |
| Edgardo Andrés Nil Guzmán    | 201801119 |
| Roberto Carlos Gómez Donis   | 202000544 |
| José Manuel Ibarra Pirir     | 202001800 |
| César André Ramírez Dávila   | 202010816 |
| Angel Francisco Sique Santos | 202012039 |

---

## Índice

- [Introducción](#introducción)
- [Bocetos de prototipos](#bocetos-de-prototipos)
- [Prototipo propuesto](#prototipo-propuesto)
- [Muckup de la aplicación](#muckup-de-la-aplicación)
  - [Sistema de seguridad (puerta)](#sistema-de-seguridad-puerta)
  - [Sistema de ventilación (ventilador)](#sistema-de-ventilación-ventilador)
- [Muckup de la web](#muckup-de-la-web)
  - [Principal](#principal)
  - [Temperatura de la habitación](#temperatura-de-la-habitación)
  - [Presencia humana](#presencia-humana)
  - [Iluminación (activa/inactiva)](#iluminación-activainactiva)
  - [Calidad del aire](#calidad-del-aire)
- [Smart Connected design Framework](#smart-connected-design-framework)
- [Diagramas de flujo](#diagramas-de-flujo)
- [MQTT](#mqtt)

# Introducción

# Bocetos de prototipos

<p align="center">
  <img src="./Prototipo/prototipo2.png" alt="Boceto de prototipo" >
</p>

# Prototipo propuesto
### Vista del prototipo desde arriba.
<p align="center">
  <img src="./Prototipo/Arriba.jpg" alt="Prototipo desde arriba" width="400">
</p>

### Vista del prototipo hacia adentro.
<p align="center">
  <img src="./Prototipo/Dentro.jpg" alt="Prototipo desde dentro" width="400">
</p>

### Vista del prototipo de frente.
<p align="center">
  <img src="./Prototipo/Frente.jpg" alt="Prototipo desde frente" width="400">
</p>

# Muckup de la aplicación

A continuación, se presentan dos mockups que representan diferentes aspectos de la aplicación:

## Sistema de seguridad (puerta)

En este mockup, se muestra el diseño de la interfaz de usuario relacionada con el sistema de seguridad de la aplicación. La imagen a continuación ilustra cómo se visualizará la información y las opciones relacionadas con la seguridad de la puerta:

<p align="center">
  <img src="./Mockups%20Phone/Seguridad.png" alt="Sistema de seguridad (puerta)" width="300">
</p>

## Sistema de ventilación (ventilador)

Este mockup representa la sección de control del sistema de ventilación en la aplicación. A través de esta interfaz, los usuarios podrán ajustar la configuración del ventilador para lograr el ambiente deseado. La siguiente imagen muestra cómo se verá esta parte de la aplicación:

<p align="center">
  <img src="./Mockups%20Phone/ventilacion.png" alt="Sistema de ventilación (ventilador)" width="300">
</p>

Estos mockups son una representación visual de las funcionalidades de la aplicación relacionadas con la seguridad de la puerta y el sistema de ventilación.

# Muckup de la web

A continuación, se presentan varios mockups que representan diferentes aspectos de la aplicación web:

## Principal

En este mockup principal, se muestra la página de inicio de la aplicación web. Proporciona una visión general de todos los aspectos clave, permitiendo a los usuarios navegar fácilmente hacia las secciones específicas de interés. La siguiente imagen muestra cómo se verá la página principal:

<p align="center">
  <img src="./Mockups%20Web/Principal.png" alt="Página principal" width="400">
</p>

## Temperatura de la habitación

Este mockup representa la sección de control de la temperatura de la habitación en la aplicación web. Los usuarios podrán ajustar la temperatura de acuerdo con sus preferencias. La siguiente imagen ilustra esta parte de la aplicación:

<p align="center">
  <img src="./Mockups%20Web/temperatura.png" alt="Temperatura de la habitación" width="400">
</p>

## Presencia humana

La aplicación web también ofrece la capacidad de detectar y mostrar la presencia humana en la habitación. El siguiente mockup muestra cómo se visualizará esta información:

<p align="center">
  <img src="./Mockups%20Web/precencia%20HUmana.png" alt="Presencia humana" width="400">
</p>

## Iluminación (activa/inactiva)

Otra característica importante es el control de la iluminación en la habitación. Este mockup representa la interfaz para activar o desactivar la iluminación según sea necesario:

<p align="center">
  <img src="./Mockups%20Web/Iluminacion.png" alt="Iluminación" width="400">
</p>

## Calidad del aire

La calidad del aire es crucial para la comodidad y la salud. La aplicación web permite a los usuarios supervisar y mejorar la calidad del aire. A continuación, se muestra cómo se presentará esta información:

<p align="center">
  <img src="./Mockups%20Web/Calidad%20de%20aire.png" alt="Calidad del aire" width="400">
</p>

Estos mockups representan visualmente las diversas funcionalidades de la aplicación web relacionadas con la página principal, la temperatura de la habitación, la presencia humana, la iluminación y la calidad del aire.

# Smart Connected design Framework

#### 1. Things

<li> Estos sensores son la parte física que forma la capa Things. Sensores de iluminación, calidad del aire y temperatura dentro de la habitación, estos capturan datos ambientales importantes en la habitación.</li>

#### 2. Hardware

##### MQ135 (Sensor de Calidad del Aire):

<li> Este sensor es un componente físico que recopila datos sobre la calidad del aire en la habitación, detectando sustancias como CO2 y otros gases nocivos.</li>

##### DHT11 (Sensor de Temperatura):

<li>Recopila datos sobre la temperatura en la habitación.</li>

##### LDR (Fotorresistor):

<li> Este componente detecta la cantidad de luz en el entorno y puede utilizarse para medir la intensidad de la iluminación en la habitación.</li>

##### Módulo Wi-Fi ESP8266-01:

<li>Requiere un firmware o programa específico para establecer la conexión Wi-Fi, comunicarse con la nube y procesar los datos.</li>

##### Ventilador 6015 de 12V, 60mm:

<li>Actúa como un método para controlar la temperatura y la ventilación en la habitación.</li>

##### Actuador:

<li>Es un dispositivo o componente que se utiliza para convertir una señal de control en un movimiento físico o acción mecánica.</li>

#### 3. Software

<p>Son dispositivos que necesitan ser controlados para recopilar y transmitir datos. Para lograr esto, se carga un firmware en cada uno de estos sensores. El firmware es un conjunto de instrucciones de bajo nivel que permite a los sensores interactuar con su entorno y comunicar los datos capturados.</p>

##### MQ135 (Sensor de Calidad del Aire):

<li> El firmware para el MQ135 podría involucrar la calibración del sensor y la conversión de las lecturas de resistencia a valores de calidad del aire.</li>

##### DHT11 (Sensor de Temperatura):

<li>Este firmware está programado en el microcontrolador del DHT11 y controla cómo el sensor interactúa con el entorno y genera las lecturas de temperatura.</li>

##### LDR (Fotorresistor):

<li> El firmware o el software correspondiente se encargará de leer la resistencia del LDR, lo que proporciona información sobre la intensidad de la luz ambiental.</li>

##### Módulo Wi-Fi ESP8266-01:

<li>Requiere un firmware personalizado que configure su conexión Wi-Fi, permita la comunicación con otros dispositivos y maneje la transmisión de datos.</li>

##### Ventilador 6015 de 12V, 60mm:

<li>Se necesita un software que permita a los usuarios ajustar la velocidad o encender y apagar el ventilador según las condiciones ambientales.</li>

##### Actuador:

<li>Se necesita programar y controlar los actuadores utilizando el Arduino Integrated Development Environment (IDE). </li>

#### 4. Comunication

<li>La comunicación se realiza mediante una conexión inalámbrica utilizando un componente Wi-Fi. Este componente Wi-Fi permite que la estación envíe datos en tiempo real a través del protocolo MQTT a un servidor MQTT centralizado. El servidor MQTT actúa como intermediario y facilita la comunicación bidireccional entre la estación y la plataforma en la nube. Los datos recopilados por la estación, que incluyen información sobre temperatura, luz, concentración de CO2 y proximidad, se transmiten de manera eficiente a través de MQTT, lo que garantiza una comunicación efectiva y confiable.</li>

#### 5. Cloud Platform

<li>AWS de un servidor MQTT que administra la comunicación de mensajes MQTT entre la estación y la nube. Además, cuenta con una base de datos, Google Cloud Database, donde se almacenan de manera persistente los datos climáticos recopilados, lo que permite su acceso y análisis en cualquier momento. También se incluye un sistema de procesamiento de datos que se encarga de analizar y presentar los datos de manera significativa, lo que facilita el monitoreo en tiempo real y el seguimiento de tendencias a lo largo del tiempo.</li>

#### 6. Cloud Applications

<li>App Inventor, esta plataforma de desarrollo nos permite crear una aplicación móvil que los usuarios pueden utilizar para interactuar con los datos recopilados por los sensores en tiempo real. Se puede diseñar la interfaz de usuario de la aplicación, permitir a los usuarios visualizar los datos de temperatura, humedad, calidad del aire y luz, y también ofrecerles la capacidad de controlar la iluminación y la ventilación en la habitación.</li><br>

<li>La aplicación web ofrece una interfaz para la visualización de datos en tiempo real, incluyendo gráficos de temperatura, presencia humana, estado de iluminación y calidad del aire, todo implementado a través de software como Grafana. Además, permite el control de la iluminación dentro de la habitación.</li>

# Diagramas de flujo
Sistema de Monitoreo Ambiental Integrado. Este prototipo de Sistema de Monitoreo Ambiental Integrado combina la tecnología de Arduino con una aplicación móvil y una página web para proporcionar a los usuarios una forma efectiva de monitorear y controlar su entorno ambiental. Este sistema tiene un gran potencial en una variedad de aplicaciones y puede mejorar la calidad de vida y la eficiencia en diferentes entornos.
### Prototipo
<p align="center">
  <img src="./Diagramas/Flujo%Prototipo.png" alt="Prototipo" width="400">
</p>

### Diagrama
<p align="center">
  <img src="./Diagramas/Diagrama%de%Flujo.png" alt="Diagrama de Flujo" width="400">
</p>

# MQTT
### ¿Qué es?
MQTT es un protocolo de mensajería basado en estándares, o un conjunto de reglas, que se utiliza para la comunicación de un equipo a otro. Los sensores inteligentes, los dispositivos portátiles y otros dispositivos de Internet de las cosas (IoT) generalmente tienen que transmitir y recibir datos a través de una red con recursos restringidos y un ancho de banda limitado. Estos dispositivos IoT utilizan MQTT para la transmisión de datos, ya que resulta fácil de implementar y puede comunicar datos IoT de manera eficiente. MQTT admite la mensajería entre dispositivos a la nube y la nube al dispositivo.

El protocolo MQTT funciona según los principios del modelo de publicación o suscripción. En la comunicación de red tradicional, los clientes y servidores se comunican directamente entre sí. Los clientes solicitan recursos o datos del servidor, a continuación el servidor procesa y envía una respuesta. Sin embargo, MQTT utiliza un patrón de publicación o suscripción para desacoplar el remitente del mensaje (*publisher*) del receptor del mensaje (*subscriber*). En lugar de ello, un tercer componente, denominado *broker*, controla la comunicación entre editores y suscriptores. El trabajo del *broker* consiste en filtrar todos los mensajes entrantes de los editores y distribuirlos correctamente a los suscriptores. 
### Broker
El *broker* es un servidor que proporciona un punto de encuentro para los dispositivos y aplicaciones que desean comunicarse entre sí. Es responsable de recibir los mensajes publicados por los *publishers* y distribuirlos a los *subscribers* que se han suscrito a los temas correspondientes.
### Tipos de Broker
* **Broker gratuitos:** Estos *brokers* son ofrecidos por empresas o organizaciones sin ánimo de lucro. Son una buena opción para aplicaciones de prueba o desarrollo. Algunos ejemplos de *brokers* gratuitos son Mosquitto, HiveMQ y Eclipse Paho.
* **Broker de pago:** Estos *brokers* ofrecen una serie de funciones y características adicionales, como seguridad, escalabilidad y soporte técnico. Algunos ejemplos de *brokers* de pago son AWS IoT Core, IBM Watson IoT Platform y Azure IoT Hub.
### Publisher
Un *publisher* es un dispositivo o aplicación que publica mensajes en un tema. Los mensajes publicados pueden ser de cualquier tipo, como datos sensor, eventos o comandos.
### Subscriber
Un *subscriber* es un dispositivo o aplicación que se suscribe a un tema para recibir los mensajes que se publican en él. Los *subscribers* pueden recibir mensajes de cualquier *publisher* que publique en el tema.