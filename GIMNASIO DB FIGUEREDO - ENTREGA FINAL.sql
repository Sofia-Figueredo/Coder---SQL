
-- Creación del esquema y selección de la base de datos
CREATE SCHEMA IF NOT EXISTS GimnasioDB;
USE GimnasioDB;

-- Tabla: Socios
CREATE TABLE IF NOT EXISTS Socios (
    IDSocio INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    Apellido VARCHAR(50) NOT NULL,
    DNI VARCHAR(10) UNIQUE NOT NULL,
    FechaNacimiento DATE NOT NULL
);

-- Tabla: Membresias
CREATE TABLE IF NOT EXISTS Membresias (
    IDMembresia INT AUTO_INCREMENT PRIMARY KEY,
    IDSocio INT,
    TipoMembresia VARCHAR(50) NOT NULL,
    Precio DECIMAL(10, 2) NOT NULL,
    FechaVencimiento DATE NOT NULL,
    FOREIGN KEY (IDSocio) REFERENCES Socios(IDSocio) ON DELETE CASCADE
);

-- Tabla: Entrenadores
CREATE TABLE IF NOT EXISTS Entrenadores (
    IDEntrenador INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    Apellido VARCHAR(50) NOT NULL,
    DNI VARCHAR(10) UNIQUE NOT NULL
);

-- Tabla: Clases
CREATE TABLE IF NOT EXISTS Clases (
    IDClase INT AUTO_INCREMENT PRIMARY KEY,
    NombreClase VARCHAR(50) NOT NULL,
    IDEntrenador INT,
    Horario DATETIME NOT NULL,
    FOREIGN KEY (IDEntrenador) REFERENCES Entrenadores(IDEntrenador) ON DELETE SET NULL
);

-- Tabla: Asistencias
CREATE TABLE IF NOT EXISTS Asistencias (
    IDAsistencia INT AUTO_INCREMENT PRIMARY KEY,
    IDClase INT,
    IDSocio INT,
    Fecha DATETIME NOT NULL,
    FOREIGN KEY (IDClase) REFERENCES Clases(IDClase) ON DELETE CASCADE,
    FOREIGN KEY (IDSocio) REFERENCES Socios(IDSocio) ON DELETE CASCADE
);

-- Vistas

-- Vista: Socios Activos
CREATE VIEW IF NOT EXISTS V_SociosActivos AS
SELECT s.IDSocio, s.Nombre, s.Apellido, m.TipoMembresia, m.FechaVencimiento
FROM Socios s
JOIN Membresias m ON s.IDSocio = m.IDSocio
WHERE m.FechaVencimiento >= CURDATE();

-- Vista: Clases por Entrenador
CREATE VIEW IF NOT EXISTS V_ClasesPorEntrenador AS
SELECT c.NombreClase, e.Nombre AS Entrenador, COUNT(a.IDAsistencia) AS CantidadAsistentes
FROM Clases c
JOIN Entrenadores e ON c.IDEntrenador = e.IDEntrenador
LEFT JOIN Asistencias a ON c.IDClase = a.IDClase
GROUP BY c.IDClase;

-- Procedimientos Almacenados

-- Procedimiento: Renovación de Membresía
DELIMITER //
CREATE PROCEDURE RenovarMembresia(IN p_IDSocio INT, IN p_TipoMembresia VARCHAR(50), IN p_Precio DECIMAL(10, 2), IN p_FechaVencimiento DATE)
BEGIN
    INSERT INTO Membresias (IDSocio, TipoMembresia, Precio, FechaVencimiento)
    VALUES (p_IDSocio, p_TipoMembresia, p_Precio, p_FechaVencimiento);
END //
DELIMITER ;

-- Triggers

-- Trigger: Actualización de fecha de vencimiento en Membresía
DELIMITER //
CREATE TRIGGER ActualizarVencimiento BEFORE UPDATE ON Membresias
FOR EACH ROW
BEGIN
    IF NEW.FechaVencimiento < CURDATE() THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La fecha de vencimiento no puede ser anterior a la fecha actual';
    END IF;
END //
DELIMITER ;

-- Carga de datos (Ejemplo de inserción de datos)

-- Inserción de Socios
INSERT INTO Socios (Nombre, Apellido, DNI, FechaNacimiento) 
VALUES 
('Juan', 'Pérez', '12345678', '1990-05-15'),
('Ana', 'Gómez', '87654321', '1985-08-22');

-- Inserción de Entrenadores
INSERT INTO Entrenadores (Nombre, Apellido, DNI) 
VALUES 
('Carlos', 'López', '11223344'),
('María', 'Rodríguez', '55667788');

-- Inserción de Clases
INSERT INTO Clases (NombreClase, IDEntrenador, Horario) 
VALUES 
('Yoga', 1, '2025-01-15 10:00:00'),
('Pilates', 2, '2025-01-15 11:00:00');

-- Inserción de Asistencias
INSERT INTO Asistencias (IDClase, IDSocio, Fecha) 
VALUES 
(1, 1, '2025-01-15 10:00:00'),
(2, 2, '2025-01-15 11:00:00');
