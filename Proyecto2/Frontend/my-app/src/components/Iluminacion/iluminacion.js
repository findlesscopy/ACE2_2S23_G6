import React from 'react';

class Iluminacion extends React.Component {
  render() {
    return (
      <li>
        <a href="#" onClick={() => this.props.mostrarInfo('iluminacion', 'Iluminación', 'https://img.icons8.com/officel/16/edison-bulb.png')}>
          <img src="https://img.icons8.com/officel/16/edison-bulb.png" alt="edison-bulb" /> Iluminación
        </a>
      </li>
    );
  }
}

export default Iluminacion;
