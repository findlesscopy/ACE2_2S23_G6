import React from 'react';

class CalidadAire extends React.Component {
  render() {
    return (
      <li>
        <a href="#" onClick={() => this.props.mostrarInfo('calidad-aire', 'Calidad de Aire', 'https://img.icons8.com/color/48/air-element.png')}>
          <img src="https://img.icons8.com/color/48/air-element.png" alt="air-element" /> Calidad de aire
        </a>
      </li>
    );
  }
}

export default CalidadAire;
