-- 3. Optimizar el uso de recursos y gestionar índices

-- Identificar índices innecesarios
SELECT DISTINCT TABLE_NAME, INDEX_NAME
FROM INFORMATION_SCHEMA.STATISTICS
WHERE TABLE_SCHEMA = 'libre';


-- Eliminar índices no utilizados
ALTER TABLE Reserva DROP INDEX idx_reserva_fecha;


-- Agregar índices para acelerar consultas
CREATE INDEX idx_fecha_reserva ON Reserva(fecha_reserva);