// CalidadAire.js
import React from 'react';

class CalidadAire extends React.Component {
  render() {
    return (
      <li>
        <a href="#" onClick={() => this.props.mostrarInfo('calidad-aire', 'Calidad de Aire', 'https://img.icons8.com/color/48/air-element.png', <iframe src="http://localhost:3000/d-solo/f7118b59-26c2-48b7-907b-68aa05783d1d/sensores-proyecto?orgId=1&tab=query&from=1696180433288&to=1696202033288&panelId=1" width="450" height="200" frameborder="0"></iframe>)}>
          <img src="https://img.icons8.com/color/48/air-element.png" alt="air-element" /> Calidad de aire
        </a>
      </li>
    );
  }
}

export default CalidadAire;
