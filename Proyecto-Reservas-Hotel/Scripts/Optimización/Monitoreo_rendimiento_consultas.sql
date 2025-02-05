-- 1. Monitorear el rendimiento de consultas
SHOW PROCESSLIST;
-- Activar el log de consultas lentas
SET GLOBAL slow_query_log = 1;
SET GLOBAL long_query_time = 2; -- Registra consultas que tardan más de 2 segundos

-- Ver el uso del caché de consultas
SHOW STATUS LIKE 'Qcache%';