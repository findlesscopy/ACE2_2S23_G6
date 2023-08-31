# Control Climático en alcobas Inteligentes a través del Análisis Meteorológico IoT.

## Integrantes

| Nombre                       | Carnet    |
| ---------------------------- | --------- |
| José Manuel Ibarra Pirir     | 202001800 |
| Roberto Carlos Gómez Donis   | 202000544 |
| Edgardo Andrés Nil Guzmán    | 20180119  |
| César André Ramírez Dávila   | 202010816 |
| Angel Francisco Sique Santos | 202012039 |

---

### Introducción

<p>

En la era actual de interconexión y automatización, los sistemas de Internet de las Cosas o IOT, han revolucionado la manera en que interactuamos con nuestro entorno. En este contexto, se presenta un sistema IoT innovador y altamente funcional diseñado para gestionar un ambiente inteligente dentro de una habitación. Este sistema no solo se enfoca en crear condiciones óptimas para los ocupantes, sino que también se centra en el análisis y control eficiente de los gastos energéticos.

</p>

<p>

Lo principal de este sistema reside en la recopilación precisa de datos provenientes de diversos sensores estratégicamente ubicados en la habitación. Estos sensores capturan información vital sobre iluminación, calidad del aire y temperatura, elementos cruciales para garantizar un espacio habitable y saludable. Los datos recolectados son transmitidos a una plataforma centralizada a través de Internet, donde se almacenan y se vuelven accesibles tanto a través de aplicaciones web como en dispositivos móviles. Esta accesibilidad permite a los usuarios no solo supervisar en tiempo real las condiciones ambientales, sino también analizar tendencias a lo largo del tiempo para una toma de decisiones informada.

</p>

El propósito fundamental de este sistema es doble: asegurar la comodidad y el bienestar del usuario mientras se optimizan los recursos energéticos. Para lograr esta hazaña, el sistema cuenta con una serie de funciones notables. Desde la manipulación de la iluminación de la habitación hasta el análisis y mejora activa de la calidad del aire, cada aspecto es meticulosamente diseñado para ser eficiente y efectivo.

<p>

Un aspecto destacado de este sistema es su capacidad de respuesta ante la presencia humana en la habitación. Cuando una persona está presente, el usuario puede tomar el control de la iluminación a través de la aplicación móvil. Por otro lado, si la habitación está desocupada, el sistema entra en una secuencia inteligente para gestionar la iluminación. A través de ciclos temporizados, el sistema emite notificaciones a la aplicación móvil sobre el estado de la iluminación, asegurando una gestión eficaz y energéticamente eficiente.

</p>

Además, el sistema se preocupa por la calidad del aire, monitoreando de cerca su composición. Si se detecta una calidad deficiente, el sistema desencadena procesos de purificación del aire, utilizando sistemas de ventilación para introducir aire fresco y eliminar las impurezas presentes. Esto garantiza un entorno saludable y propicio para la ocupación.

### Boceto Prototipo

### Construcción Prototipo

### Aplicación Móvil

### Framework IOT

#### 1. Things

<li> Estos sensores son la parte física que forma la capa Things. Sensores de iluminación, calidad del aire y temperatura dentro de la habitación, estos capturan datos ambientales importantes en la habitación.</li>

#### 2. Hardware

##### MQ135 (Sensor de Calidad del Aire):

<li> Este sensor es parte de la capa de "Hardware", ya que es un componente físico que recopila datos sobre la calidad del aire en la habitación, detectando sustancias como CO2 y otros gases nocivos.</li>

##### DHT11 (Sensor de Temperatura y Humedad):

<li>Recopila datos sobre la temperatura y la humedad ambiental en la habitación.</li>

##### LDR (Fotorresistor):

<li> Este componente detecta la cantidad de luz en el entorno y puede utilizarse para medir la intensidad de la iluminación en la habitación.</li>

##### Módulo Wi-Fi ESP8266-01:

<li>Requiere un firmware o programa específico para establecer la conexión Wi-Fi, comunicarse con la nube y procesar los datos.</li>

##### Ventilador 6015 de 12V, 60mm:

<li>Actúa como un método para controlar la temperatura y la ventilación en la habitación.</li>

#### 3. Software

<p>Son dispositivos que necesitan ser controlados para recopilar y transmitir datos. Para lograr esto, se carga un firmware en cada uno de estos sensores. El firmware es un conjunto de instrucciones de bajo nivel que permite a los sensores interactuar con su entorno y comunicar los datos capturados.</p>

##### MQ135 (Sensor de Calidad del Aire):

<li> El firmware para el MQ135 podría involucrar la calibración del sensor y la conversión de las lecturas de resistencia a valores de calidad del aire.</li>

##### DHT11 (Sensor de Temperatura y Humedad):

<li>Este firmware está programado en el microcontrolador del DHT11 y controla cómo el sensor interactúa con el entorno y genera las lecturas de temperatura y humedad.</li>

##### LDR (Fotorresistor):

<li> El firmware o el software correspondiente se encargará de leer la resistencia del LDR, lo que proporciona información sobre la intensidad de la luz ambiental.</li>

##### Módulo Wi-Fi ESP8266-01:

<li>Requiere un firmware personalizado que configure su conexión Wi-Fi, permita la comunicación con otros dispositivos y maneje la transmisión de datos.</li>

##### Ventilador 6015 de 12V, 60mm:

<li>Se necesita un software que permita a los usuarios ajustar la velocidad o encender y apagar el ventilador según las condiciones ambientales.</li>

#### 4. Comunication

<li> Los sensores mencionados, recopilan información sobre temperatura, humedad, calidad del aire y luz. Cada sensor opera con su firmware para adquirir y preparar datos. Los datos son transmitidos por el módulo Wi-Fi ESP8266-01 mediante su firmware, estableciendo conexión Wi-Fi y transferencia de datos a una aplicación web. La aplicación web, recibe y muestra los datos en tiempo real para los usuarios. Luego, estos datos son almacenados en una base de datos, que puede ser local o en la nube, permitiendo un acceso continuo y un análisis de los datos recopilados por los sensores. Cada etapa de este proceso depende de software específico que asegura la correcta comunicación, procesamiento y almacenamiento de los datos.</li>

#### 5. Cloud Platform

<li>Google Cloud Database, representa la solución de almacenamiento en la nube donde los datos recopilados por los sensores mencionados, son enviados a través del módulo Wi-Fi. Estos datos se almacenan de manera segura y escalable en la base de datos en la nube o local. La aplicación móvil creada con "App Inventor" tiene la capacidad de acceder y mostrar estos datos almacenados, lo que permite a los usuarios monitorear y controlar las condiciones de la habitación en tiempo real.</li>

#### 6. Cloud Applications

<li>App Inventor, esta plataforma de desarrollo nos permite crear una aplicación móvil que los usuarios pueden utilizar para interactuar con los datos recopilados por los sensores en tiempo real. Se puede diseñar la interfaz de usuario de la aplicación, permitir a los usuarios visualizar los datos de temperatura, humedad, calidad del aire y luz, y también ofrecerles la capacidad de controlar la iluminación y la ventilación en la habitación.</li>
