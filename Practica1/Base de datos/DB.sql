CREATE TABLE MedicionesAmbiente (
    id INT AUTO_INCREMENT PRIMARY KEY,
    temperatura DECIMAL(5, 2) NOT NULL,
    luz INT NOT NULL,
    humedad DECIMAL(5, 2) NOT NULL,
    calidad_aire INT NOT NULL
);
