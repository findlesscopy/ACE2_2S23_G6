import React from 'react';

class CalidadAire extends React.Component {
  render() {
    return (
      <li>
        <a href="#" onClick={() => this.props.mostrarInfo('calidad-aire', 'Calidad de Aire', 'https://img.icons8.com/color/48/air-element.png',<iframe src="http://localhost:3000/d-solo/d356478b-f2f3-41c1-9025-378ccf50acea/distancia?orgId=1&refresh=10s&from=1697842020004&to=1697863620004&panelId=2" width="450" height="200" frameborder="0"></iframe>)}>
          <img src="https://img.icons8.com/color/48/air-element.png" alt="air-element" /> Calidad de aire
        </a>
      </li>
    );
  }
}

export default CalidadAire;
