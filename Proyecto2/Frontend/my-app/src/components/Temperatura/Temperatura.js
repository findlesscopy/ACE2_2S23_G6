import React from 'react';

class Temperatura extends React.Component {
  render() {
    return (
      <li>
        <a href="#" onClick={() => this.props.mostrarInfo('temperatura', 'Temperatura', 'https://img.icons8.com/clouds/100/temperature.png')}>
          <img src="https://img.icons8.com/clouds/100/temperature.png" alt="temperature" />Temperatura
        </a>
      </li>
    );
  }
}

export default Temperatura;
