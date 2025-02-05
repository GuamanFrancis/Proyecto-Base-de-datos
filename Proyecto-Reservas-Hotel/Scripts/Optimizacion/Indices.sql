
-- Creacion de index

-- Despues de realizar una consulta y entender para que nos sirven los indices hemos llegado a la idea de que estos indices son los mas primordiales en 
-- nuestro proyecto dado nuestras necesidades actuales pero en el caso de que se incrementen las consultas es necesario analizar nuevamente estos
-- problemas que puedan existir

-- Índice para búsquedas rápidas por cliente y fecha de reserva

CREATE INDEX idx_cliente_fecha ON Reserva (cliente_id, fecha_reserva);


-- Índice compuesto para validar disponibilidad de habitaciones

CREATE INDEX idx_habitacion_fecha ON Reserva (habitacion_id, fecha_reserva);

-- Índice para la tabla Pago

CREATE INDEX idx_pago_reserva ON Pago (reserva_id);

-- Índice para la tabla Factura

CREATE INDEX idx_factura_reserva ON Factura (reserva_id);




