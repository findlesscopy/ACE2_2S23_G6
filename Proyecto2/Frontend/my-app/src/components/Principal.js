import React from 'react';
import './Principal.css';

function Principal() {
  return (
    <div className="Principal">
      <header className="App-header">
        <h1>Grupo 6</h1>
        <ul>
          <li>Edgardo Andrés Nil Guzmán - 201801119</li>
          <li>Roberto Carlos Gómez Donis - 202000544</li>
          <li>José Manuel Ibarra Pirir - 202001800</li>
          <li>César André Ramírez Dávila - 202010816</li>
          <li>Angel Francisco Sique Santos - 202012039</li>
        </ul>
        <button onClick={() => window.location.href = '/Graficos'}>Ir a Graficos</button>
      </header>
    </div>
  );
}

export default Principal;
