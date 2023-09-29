import React from 'react';
import './Graficos.css';
import Temperatura from '../Temperatura/Temperatura';
import PresenciaHumana from '../PrecenciaHumana/PrecenciaHumana';
import Iluminacion from '../Iluminacion/iluminacion';
import CalidadAire from '../CalidadAire/CalidadAire';

class Grafico extends React.Component {
  componentDidMount() {
    // Mostrar el cuadro de temperatura al cargar la página
    this.mostrarInfo('temperatura', 'Temperatura', 'https://img.icons8.com/clouds/100/temperature.png');
  }

  mostrarInfo(id, nombreHabitacion, iconoURL) {
    // Obtener el elemento contenedor
    var infoHabitacion = document.getElementById('info-habitacion');

    // Crear el contenido HTML para mostrar
    var contenido = `
        <h2>${nombreHabitacion}</h2>
        <img src="${iconoURL}" alt="${nombreHabitacion} Icono"/>
    `;

    // Colocar el contenido en el contenedor
    infoHabitacion.innerHTML = contenido;
  }

  render() {
    return (
      <div>
        <nav className="navbar">
          <ul>
            {/* Utilizar el componente Temperatura */}
            <Temperatura mostrarInfo={this.mostrarInfo} />
            {/* Utilizar el componente PrecenciaHumana */}
            <PresenciaHumana mostrarInfo={this.mostrarInfo} />
            {/* Utilizar el componente Iluminacion */}
            <Iluminacion mostrarInfo={this.mostrarInfo} />
            {/* Utilizar el componente CalidadAire */}
            <CalidadAire mostrarInfo={this.mostrarInfo} />
            <li>
              <a href="/">
                <img src="https://img.icons8.com/pastel-glyph/64/web-account--v1.png" alt="Principal" /> Principal
              </a>
            </li>
          </ul>
        </nav>
        {/* Contenedor para mostrar la información de la habitación */}
        <div id="info-habitacion" className="info-habitacion"></div>
      </div>
    );
  }
}

export default Grafico;
