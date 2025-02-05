

-- Particionamiento por rango en Reserva (por año de reserva)

CREATE TABLE ReservaParticionada (
    id INT NOT NULL,
    cliente_id INT NOT NULL,
    habitacion_id INT NOT NULL,
    fecha_reserva DATE NOT NULL,
    dias_estadia INT NOT NULL,
    estado_pago BOOLEAN,
    PRIMARY KEY (id, fecha_reserva)
)
PARTITION BY RANGE (YEAR(fecha_reserva)) (
    PARTITION p2023 VALUES LESS THAN (2024),
    PARTITION p2024 VALUES LESS THAN (2025),
    PARTITION p2025 VALUES LESS THAN (2026)
);



--  Particionamiento por lista en Pago (por método de pago)

CREATE TABLE Pago (
    id INT NOT NULL PRIMARY KEY,
    metodo_pago ENUM('Efectivo', 'Tarjeta', 'Transferencia') NOT NULL,
    total DOUBLE NOT NULL,
    fecha_pago DATE NOT NULL,
    reserva_id INT NOT NULL
)
PARTITION BY LIST COLUMNS (metodo_pago) (
    PARTITION efectivo VALUES IN ('Efectivo'),
    PARTITION tarjeta VALUES IN ('Tarjeta'),
    PARTITION transferencia VALUES IN ('Transferencia')
);


-- Particionamiento por hash en Factura (por reserva_id)

CREATE TABLE Factura (
    id INT NOT NULL PRIMARY KEY,
    reserva_id INT NOT NULL,
    fecha_emision DATE NOT NULL
)
PARTITION BY HASH(reserva_id)
PARTITIONS 4;
