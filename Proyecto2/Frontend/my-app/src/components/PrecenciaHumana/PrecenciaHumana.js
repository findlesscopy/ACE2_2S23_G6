import React from 'react';

class PresenciaHumana extends React.Component {
  render() {
    return (
      <li>
        <a href="#" onClick={() => this.props.mostrarInfo('presencia', 'Presencia Humana', 'https://img.icons8.com/office/16/amputee.png')}>
          <img src="https://img.icons8.com/office/16/amputee.png" alt="amputee" /> Presencia humana
        </a>
      </li>
    );
  }
}

export default PresenciaHumana;
