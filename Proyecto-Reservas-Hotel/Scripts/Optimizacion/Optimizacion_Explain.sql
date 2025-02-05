

-- Uso de Explain

-- Consuta hecha con index 

EXPLAIN SELECT * FROM Reserva WHERE cliente_id = 5;

-- Consulta hecha sin index 
EXPLAIN SELECT r.*, p.total FROM Reserva r JOIN Pago p ON r.id = p.reserva_id;


-- Escaneo  con indices

 EXPLAIN SELECT * FROM Reserva WHERE cliente_id = 4 AND fecha_reserva BETWEEN '2023-01-01' AND '2025-01-10';


EXPLAIN SELECT r.*, p.total FROM Reserva r JOIN Pago p ON r.id = p.reserva_id WHERE r.cliente_id = 2 AND p.total > 200;





