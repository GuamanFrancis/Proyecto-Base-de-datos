

--  Trigger

-- Tabla de auditoría para registrar cambios

CREATE TABLE Auditoria (
    id INT AUTO_INCREMENT PRIMARY KEY,
    accion VARCHAR(100) NOT NULL,
    tabla_afectada VARCHAR(100) NOT NULL,
    id_registro INT NOT NULL,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    detalle TEXT
);

-- Tabla de historial de pagos para llevar un control de cambios

CREATE TABLE HistorialPagos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    reserva_id INT NOT NULL,
    metodo_pago ENUM('Efectivo', 'Tarjeta', 'Transferencia') NOT NULL,
    total DOUBLE NOT NULL,
    fecha_pago TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (reserva_id) REFERENCES Reserva(id)
);


-- Trigger para auditar la eliminación de reservas
DELIMITER //
CREATE TRIGGER trigger_auditar_eliminacion_reserva
AFTER DELETE ON Reserva
FOR EACH ROW
BEGIN
    INSERT INTO Auditoria (accion, tabla_afectada, id_registro, detalle)
    VALUES ('Eliminación', 'Reserva', OLD.id, CONCAT('Reserva eliminada para la habitación: ', OLD.habitacion_id));
END //
delimiter ;



-- Trigger para actualizar el estado de la habitación al eliminar una reserva
DELIMITER //
CREATE TRIGGER trigger_actualizar_estado_habitacion_eliminada
AFTER DELETE ON Reserva
FOR EACH ROW
BEGIN
    UPDATE Habitacion
    SET estado = 1  -- Marcar la habitación como disponible
    WHERE id = OLD.habitacion_id;
END //
DELIMITER ;

select * from auditoria;

-- Trigger para auditar cambios en el estado de pago de las reservas

DELIMITER //
CREATE TRIGGER trigger_auditar_cambio_estado_pago
AFTER UPDATE ON Reserva
FOR EACH ROW
BEGIN
    IF OLD.estado_pago != NEW.estado_pago THEN
        -- Insertar el registro en la tabla Auditoria
        INSERT INTO Auditoria (accion, tabla_afectada, id_registro, fecha, detalle)
        VALUES ('Actualización', 'Reserva', OLD.id, NOW(), 
                CONCAT('Cambio en estado_pago: De ', OLD.estado_pago, ' a ', NEW.estado_pago));
    END IF;
END //
DELIMITER ;




-- Trigger para actualizar el estado de la habitación al realizar una nueva reserva
DELIMITER //
CREATE TRIGGER trigger_actualizar_estado_habitacion_reserva
AFTER INSERT ON Reserva
FOR EACH ROW
BEGIN
    UPDATE Habitacion
    SET estado = 0  -- Marcar la habitación como ocupada
    WHERE id = NEW.habitacion_id;
END //
DELIMITER ;

-- Trigger para generar factura de pago automaticamente

DELIMITER //
CREATE TRIGGER trigger_generar_factura_pago_completado
AFTER INSERT ON Pago
FOR EACH ROW
BEGIN
    DECLARE estadoPago BOOLEAN;
    
    -- Obtener el estado de pago de la reserva
    SELECT estado_pago INTO estadoPago
    FROM Reserva
    WHERE id = NEW.reserva_id;

    -- Verificar si el estado de pago está completado (1)
    IF estadoPago = 1 THEN
        -- Generar la factura automáticamente
        INSERT INTO Factura (reserva_id) VALUES (NEW.reserva_id);
    END IF;
END //
DELIMITER ;



-- Trigger para impedir la creación de reservas en habitaciones ya ocupadas

DELIMITER //
CREATE TRIGGER trigger_impedir_reserva_habitacion_ocupada
BEFORE INSERT ON Reserva
FOR EACH ROW
BEGIN
    DECLARE fechaFin DATE;
    SET fechaFin = DATE_ADD(NEW.fecha_reserva, INTERVAL NEW.dias_estadia DAY);
    
    -- Verificar si la habitación ya está ocupada en las fechas solicitadas
    IF EXISTS (
        SELECT 1
        FROM Reserva
        WHERE habitacion_id = NEW.habitacion_id
        AND (fecha_reserva BETWEEN NEW.fecha_reserva AND fechaFin
             OR DATE_ADD(fecha_reserva, INTERVAL dias_estadia DAY) BETWEEN NEW.fecha_reserva AND fechaFin)
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La habitación ya está ocupada en esas fechas.';
    END IF;
END //
DELIMITER ;

-- Trigger para actualizar el estado de pago cuando se inserta un nuevo pago

DELIMITER //
CREATE TRIGGER trigger_actualizar_estado_pago
AFTER INSERT ON Pago
FOR EACH ROW
BEGIN
    UPDATE Reserva
    SET estado_pago = 1  
    WHERE id = NEW.reserva_id;
END //
DELIMITER ;
