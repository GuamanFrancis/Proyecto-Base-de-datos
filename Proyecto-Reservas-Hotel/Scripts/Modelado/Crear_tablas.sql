CREATE TABLE Cliente (                            
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    correo_electronico VARCHAR(100),
    telefono VARCHAR(15)
);
CREATE TABLE Habitacion (
    id INT AUTO_INCREMENT PRIMARY KEY,
    numero_habitacion INT NOT NULL,
    precio DOUBLE NOT NULL,
    estado BOOLEAN NOT NULL,
    tipohabitacion_id INT NOT NULL,
    FOREIGN KEY (tipohabitacion_id) REFERENCES Tipo_Habitacion(id)
);
CREATE TABLE Tipo_Habitacion (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    capacidad INT NOT NULL
);
CREATE TABLE Reserva (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT NOT NULL,
    habitacion_id INT NOT NULL,
    fecha_reserva DATE NOT NULL,
    dias_estadia INT NOT NULL,
    estado_pago BOOLEAN NOT NULL,
    servicios_id INT,
    FOREIGN KEY (cliente_id) REFERENCES Cliente(id),
    FOREIGN KEY (habitacion_id) REFERENCES Habitacion(id)
);
CREATE TABLE Servicios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    precio DOUBLE NOT NULL,
    descripcion TEXT
);
CREATE TABLE Pago (
    id INT AUTO_INCREMENT PRIMARY KEY,
    metodo_pago ENUM('Efectivo', 'Tarjeta', 'Transferencia') NOT NULL,
    total DOUBLE NOT NULL,
    fecha_pago DATE NOT NULL,
    reserva_id INT NOT NULL,
    FOREIGN KEY (reserva_id) REFERENCES Reserva(id)
);
CREATE TABLE Empleados (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    puesto ENUM('Gerente', 'Empleado') NOT NULL,
    telefono VARCHAR(15),
    salario DOUBLE NOT NULL,
    correo_electronico VARCHAR(100),
    fecha_contratacion DATE NOT NULL
);
CREATE TABLE Hotel (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    direccion_id INT NOT NULL,
    categoria_hotel_id INT,
    empleados_id INT,
    numero_habitaciones INT NOT NULL,
    FOREIGN KEY (categoria_hotel_id) REFERENCES Categoria_Hotel(id),
    FOREIGN KEY (empleados_id) REFERENCES Empleados(id)
);
CREATE TABLE Categoria_Hotel (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    puntuacion INT NOT NULL
);
CREATE TABLE Direccion (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pais VARCHAR(100) NOT NULL,
    ciudad VARCHAR(100) NOT NULL,
    sector VARCHAR(100),
    calle_principal VARCHAR(100),
    calle_secundaria VARCHAR(100)
);
CREATE TABLE Factura (
    id INT AUTO_INCREMENT PRIMARY KEY,
    reserva_id INT NOT NULL,
    FOREIGN KEY (reserva_id) REFERENCES Reserva(id)
);