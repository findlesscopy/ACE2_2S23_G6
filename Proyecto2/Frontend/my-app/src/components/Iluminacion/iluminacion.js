import React from 'react';

class Iluminacion extends React.Component {
  render() {
    return (
      <li>
        <a href="#" onClick={() => this.props.mostrarInfo('iluminacion', 'Iluminación', 'https://img.icons8.com/officel/16/edison-bulb.png', <iframe src="http://localhost:3000/d-solo/f7118b59-26c2-48b7-907b-68aa05783d1d/sensores-proyecto?orgId=1&tab=query&from=1696181883090&to=1696203483090&panelId=3" width="450" height="200" frameborder="0"></iframe>)}>
          <img src="https://img.icons8.com/officel/16/edison-bulb.png" alt="edison-bulb" /> Iluminación
        </a>
      </li>
    );
  }
}

export default Iluminacion;
