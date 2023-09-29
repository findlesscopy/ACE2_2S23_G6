import './App.css';
import Principal from './components/Principal';
import {BrowserRouter as Router, Route, Routes} from 'react-router-dom';
import Graficos from './components/Graficos/Graficos';


function App() {
  return (
      <Router>
        <Routes>
          <Route path="/" element={<Principal />} />
          <Route path="/Graficos" element={<Graficos />} />
        </Routes>
        
      </Router>
  );
}

export default App;