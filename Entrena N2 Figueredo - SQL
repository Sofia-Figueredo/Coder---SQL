
-- Entrega 2: Proyecto Gimnasio

-- Creación de Vistas

CREATE VIEW V_SociosActivos AS
SELECT
    s.IDSocio,
    s.Nombre,
    s.Apellido,
    m.TipoMembresia,
    m.FechaVencimiento
FROM
    Socios s
INNER JOIN
    Membresias m ON s.IDSocio = m.IDSocio
WHERE
    m.FechaVencimiento >= GETDATE();

CREATE VIEW V_ClasesPorEntrenador AS
SELECT
    c.NombreClase,
    e.Nombre AS NombreEntrenador,
    c.Horario,
    COUNT(a.IDAsistencia) AS CantidadAsistentes
FROM
    Clases c
INNER JOIN
    Entrenadores e ON c.IDEntrenador = e.IDEntrenador
LEFT JOIN
    Asistencias a ON c.IDClase = a.IDClase
GROUP BY
    c.NombreClase, e.Nombre, c.Horario;

-- Creación de Funciones

CREATE FUNCTION fn_CalcularEdad(@FechaNacimiento DATE)
RETURNS INT
AS
BEGIN
    RETURN DATEDIFF(YEAR, @FechaNacimiento, GETDATE()) -
           CASE WHEN MONTH(@FechaNacimiento) > MONTH(GETDATE()) OR
                     (MONTH(@FechaNacimiento) = MONTH(GETDATE()) AND DAY(@FechaNacimiento) > DAY(GETDATE()))
                THEN 1 ELSE 0 END;
END;

CREATE FUNCTION fn_CalcularMontoPendiente(@IDSocio INT)
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @MontoTotal DECIMAL(10, 2);
    DECLARE @PagosRealizados DECIMAL(10, 2);

    SELECT @MontoTotal = Precio
    FROM Membresias
    WHERE IDSocio = @IDSocio;

    SELECT @PagosRealizados = SUM(Monto)
    FROM Pagos
    WHERE IDSocio = @IDSocio;

    RETURN ISNULL(@MontoTotal, 0) - ISNULL(@PagosRealizados, 0);
END;

-- Creación de Procedimientos Almacenados

CREATE PROCEDURE sp_RegistrarAsistencia
    @IDClase INT,
    @IDSocio INT,
    @Fecha DATETIME
AS
BEGIN
    INSERT INTO Asistencias (IDClase, IDSocio, Fecha)
    VALUES (@IDClase, @IDSocio, @Fecha);
END;

CREATE PROCEDURE sp_RenovarMembresia
    @IDSocio INT,
    @NuevaFechaVencimiento DATE
AS
BEGIN
    UPDATE Membresias
    SET FechaVencimiento = @NuevaFechaVencimiento
    WHERE IDSocio = @IDSocio;
END;

-- Inserción de datos

INSERT INTO Socios (IDSocio, Nombre, Apellido, DNI, FechaNacimiento)
VALUES (1, 'Sofía', 'Figueredo', '12345678', '2003-05-12');

INSERT INTO Membresias (IDMembresia, IDSocio, TipoMembresia, Precio, FechaVencimiento)
VALUES (1, 1, 'Mensual', 5000, '2024-12-31');

INSERT INTO Entrenadores (IDEntrenador, Nombre, Apellido, DNI)
VALUES (1, 'Juan', 'Pérez', '87654321');

INSERT INTO Clases (IDClase, NombreClase, IDEntrenador, Horario)
VALUES (1, 'Zumba', 1, '2024-12-18 18:00:00');

INSERT INTO Asistencias (IDAsistencia, IDClase, IDSocio, Fecha)
VALUES (1, 1, 1, '2024-12-18 18:05:00');
