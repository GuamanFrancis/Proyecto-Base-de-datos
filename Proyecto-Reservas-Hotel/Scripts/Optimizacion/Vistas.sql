
-- Vistas

-- Vista que muestra la información de las reservas activas

CREATE VIEW vista_reservas_activas AS
SELECT r.id AS reserva_id,
       c.nombres AS cliente_nombres,
       c.apellidos AS cliente_apellidos,
       h.numero_habitacion,
       r.fecha_reserva,
       r.dias_estadia,
       r.estado_pago
FROM Reserva r
JOIN Cliente c ON r.cliente_id = c.id
JOIN Habitacion h ON r.habitacion_id = h.id
WHERE r.estado_pago = 1;  
-- Toca mencionar que solo muestra las reservas pagadas

-- Consultar todas las reservas activas

SELECT * FROM vista_reservas_activas;



-- -----------------------------------------------------------------------------


-- Vista para mostrar detalles de las habitaciones con su tipo y estado

CREATE VIEW vista_habitaciones_detalle AS
SELECT h.id AS habitacion_id,
       h.numero_habitacion,
       h.precio,
       h.estado,
       t.nombre AS tipo_habitacion
FROM Habitacion h
JOIN Tipo_Habitacion t ON h.tipohabitacion_id = t.id;

-- Consultar las habitaciones con su tipo y estado

SELECT * FROM vista_habitaciones_detalle;

-- -----------------------------------------------------------------------------

-- Vista que muestra los pagos realizados por cada reserva

CREATE VIEW vista_pagos_reserva AS
SELECT p.id AS pago_id,
       p.metodo_pago,
       p.total,
       p.fecha_pago,
       r.id AS reserva_id
FROM Pago p
JOIN Reserva r ON p.reserva_id = r.id
WHERE p.total > 0;

-- Consultar los pagos realizados por cada reserva

SELECT * FROM vista_pagos_reserva;


-- -----------------------------------------------------------------------------

-- Vista para consultar los empleados y su puesto

CREATE VIEW vista_empleados AS
SELECT e.id AS empleado_id,
       e.nombres,
       e.apellidos,
       e.puesto,
       e.salario,
       e.fecha_contratacion
FROM Empleados e;

-- Consultar información de los empleados

SELECT * FROM vista_empleados;

-- -----------------------------------------------------------------------------

-- Vista que muestra la información básica de los hoteles

CREATE VIEW vista_hoteles AS
SELECT h.id AS hotel_id,
       h.nombre AS hotel_nombre,
       d.ciudad AS ciudad,
       d.pais AS pais,
       h.numero_habitaciones
FROM Hotel h
JOIN Direccion d ON h.direccion_id = d.id;

-- Consultar los hoteles con su ubicación

SELECT * FROM vista_hoteles;


-- -----------------------------------------------------------------------------

-- Vista de las reservas con los servicios asociados

CREATE VIEW vista_reservas_servicios AS
SELECT r.id AS reserva_id,
       r.fecha_reserva,
       r.dias_estadia,
       r.estado_pago,
       s.nombre AS servicio_nombre,
       s.precio AS servicio_precio
FROM Reserva r
JOIN Servicios s ON r.servicios_id = s.id
WHERE r.estado_pago = 1;
 -- Solo reservas pagadas con servicios

-- Consultar las reservas con los servicios asociados

SELECT * FROM vista_reservas_servicios;



 -- -----------------------------------------------------------------------------

-- Vista para obtener información sobre las facturas generadas

CREATE VIEW vista_facturas_generadas AS
SELECT f.id AS factura_id,
       f.reserva_id,
       r.fecha_reserva,
       r.dias_estadia,
       p.total AS total_pago
FROM Factura f
JOIN Reserva r ON f.reserva_id = r.id
JOIN Pago p ON r.id = p.reserva_id;


-- Consultar las facturas generadas

SELECT * FROM vista_facturas_generadas;













