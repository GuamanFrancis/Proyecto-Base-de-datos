-- Prodecidimientos Almacenados

--  Registrar nueva reserva

DELIMITER //
CREATE PROCEDURE registrar_reserva(
    IN clienteId INT,
    IN habitacionId INT,
    IN fechaReserva DATE,
    IN diasEstadia INT,
    IN estadoPago BOOLEAN
)
BEGIN
    
    INSERT INTO Reserva (cliente_id, habitacion_id, fecha_reserva, dias_estadia, estado_pago)
    VALUES (clienteId, habitacionId, fechaReserva, diasEstadia, estadoPago);
END //
DELIMITER ;


-- Llamado al procedimiento Almacenado

CALL registrar_reserva(1, 2, '2025-05-06', 1, false);

-- Comprobacion 
Select * from reserva;
Select * from habitacion;

-- --------------------------------------------------------------------------------------
-- Generar factura automáticamente para una reserva


DELIMITER //
CREATE PROCEDURE generar_factura(IN reservaId INT)
BEGIN
  
    IF EXISTS (
        SELECT 1 
        FROM Reserva 
        WHERE id = reservaId AND estado_pago = 1
    ) THEN
        INSERT INTO Factura (reserva_id) VALUES (reservaId);
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La reserva no está pagada o no existe.';
    END IF;
END //
DELIMITER ;


-- Llamado al procedimiento Almacenado

call generar_factura(2);

-- Comprobacion 
-- Con este procedimiento logramos que al momento de generar una factura si no esta cancelada no se genera la factura caso contrario si ya esta
-- efectuado el pago se genera sin ningun problema 
Select * from reserva;
Select * from pago;
Select * from factura;


-- ------------------------------------------------------------------------------------


-- Eliminar una reserva y liberar la habitación asociada

DELIMITER //
CREATE PROCEDURE eliminar_reserva(IN reservaId INT)
BEGIN
    DECLARE habitacionId INT;

    
    SELECT habitacion_id INTO habitacionId FROM Reserva WHERE id = reservaId;

    
    IF habitacionId IS NOT NULL THEN
      
        DELETE FROM Reserva WHERE id = reservaId;
        
        UPDATE Habitacion SET estado = 1 WHERE id = habitacionId;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La reserva no existe';
    END IF;
END //
DELIMITER ;

-- Llamado al procedimiento Almacenado

call eliminar_reserva(15);

-- Comprobacion 
-- en este caso eliminamos la reserva mediante el id y actualizamos la habitacion a disponible 
Select * from reserva;
Select * from habitacion;

-- ------------------------------------------------------------------------------------

-- Consultar ingresos por rango de fechas

DELIMITER //
CREATE PROCEDURE consultar_ingresos(IN fechaInicio DATE, IN fechaFin DATE)
BEGIN
    SELECT SUM(Pago.total) AS total_ingresos
    FROM Pago
    JOIN Reserva ON Pago.reserva_id = Reserva.id
    WHERE Reserva.fecha_reserva BETWEEN fechaInicio AND fechaFin;
END //
DELIMITER ;

-- Llamado al procedimiento Almacenado

call consultar_ingresos("2023-10-01","2023-10-10");

-- Comprobacion 
-- en este caso consultamos los ingresos mediante fechas










