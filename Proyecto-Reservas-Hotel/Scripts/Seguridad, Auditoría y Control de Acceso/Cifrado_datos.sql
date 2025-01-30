-- Cifrar datos sensibles
-- Para las contraseñas o datos críticos, usa AES_ENCRYPT
ALTER TABLE Cliente ADD COLUMN password VARBINARY(255);

-- Usando SHA256 para generar una clave de 16 bytes (128 bits)
INSERT INTO Cliente (nombres, apellidos, correo_electronico, telefono, password)
VALUES ('Juan', 'Pérez', 'juan@gmail.com', '123456789', AES_ENCRYPT('clave_secreta', SUBSTRING(SHA2('clave_secreta', 256), 1, 16)));

-- Usando la misma clave derivada para desencriptar
SELECT AES_DECRYPT(password, SUBSTRING(SHA2('clave_secreta', 256), 1, 16)) FROM Cliente WHERE id = 1;
