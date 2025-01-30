-- Habilitar auditoría y registrar eventos
-- Crea una tabla de auditoría y usar triggers
CREATE TABLE Auditoria (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tabla_afectada VARCHAR(100),
    accion VARCHAR(50),
    usuario VARCHAR(100),
    id_registro_afectado INT,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$

CREATE TRIGGER auditoria_reserva
AFTER INSERT ON Reserva
FOR EACH ROW
BEGIN
   INSERT INTO Auditoria (tabla_afectada, accion, usuario, id_registro_afectado)
   VALUES ('Reserva', 'INSERT', CURRENT_USER(), NEW.id);
END $$

CREATE TRIGGER auditoria_reserva_update
AFTER UPDATE ON Reserva
FOR EACH ROW
BEGIN
   IF OLD.estado_pago <> NEW.estado_pago THEN
      INSERT INTO Auditoria (tabla_afectada, accion, usuario, id_registro_afectado)
      VALUES ('Reserva', CONCAT('UPDATE - estado_pago de ', OLD.estado_pago, ' a ', NEW.estado_pago), CURRENT_USER(), NEW.id);
   END IF;
END $$

DELIMITER ;