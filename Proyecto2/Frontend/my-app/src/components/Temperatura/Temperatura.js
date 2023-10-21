import React from 'react';

class Temperatura extends React.Component {
  render() {
    return (
      <li>
        <a href="#" onClick={() => this.props.mostrarInfo('temperatura', 'Temperatura', 'https://img.icons8.com/clouds/100/temperature.png', <iframe src="http://localhost:3000/d-solo/f7118b59-26c2-48b7-907b-68aa05783d1d/sensores-proyecto?orgId=1&from=1696180939238&to=1696202539238&panelId=2" width="450" height="200" frameborder="0"></iframe>)}>
          <img src="https://img.icons8.com/clouds/100/temperature.png" alt="temperature" />Temperatura
        </a>
      </li>
    );
  }
}

export default Temperatura;
