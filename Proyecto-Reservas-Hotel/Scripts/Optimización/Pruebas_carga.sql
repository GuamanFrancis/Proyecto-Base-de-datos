-- 2. Realizar pruebas de carga
-- Probar con una gran cantidad de datos
INSERT INTO Reserva (cliente_id, habitacion_id, fecha_reserva, dias_estadia, estado_pago)
SELECT Cliente.id, 4, CURDATE(), 3, 0 
FROM Cliente 
CROSS JOIN (SELECT 1 UNION SELECT 2 UNION SELECT 3) AS x;

--  Simular muchas consultas
SELECT SQL_NO_CACHE * FROM Reserva WHERE fecha_reserva > NOW() - INTERVAL 30 DAY;