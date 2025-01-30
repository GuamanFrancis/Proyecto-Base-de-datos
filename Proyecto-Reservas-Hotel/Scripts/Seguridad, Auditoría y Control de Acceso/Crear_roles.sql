--  Implementar políticas de acceso y seguridad
-- Crear usuarios con sus permisos directamente

CREATE USER 'admin_user'@'localhost' IDENTIFIED BY 'password1';
CREATE USER 'empleado_user'@'localhost' IDENTIFIED BY 'password2';
CREATE USER 'auditor_user'@'localhost' IDENTIFIED BY 'password3';

GRANT ALL PRIVILEGES ON libre.* TO 'admin_user'@'localhost' WITH GRANT OPTION;-- Esto permite que admin pueda otorgar permisos, pero no le da acceso a todo por defecto.
GRANT SELECT, INSERT, UPDATE ON libre.Reserva TO 'empleado_user'@'localhost';
GRANT SELECT ON libre.Cliente TO 'auditor_user'@'localhost';
