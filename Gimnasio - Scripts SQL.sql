CREATE TABLE IF NOT EXISTS `mydb`.`Socios` (
  `ID` VARCHAR(255) NOT NULL,
  `nombre y apellido` VARCHAR(100) NOT NULL,
  `telefono` VARCHAR(32) NOT NULL,
  `email` VARCHAR(45) NULL,
  `tipo de membresia` VARCHAR(45) NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  UNIQUE INDEX `nombre y apellido_UNIQUE` (`nombre y apellido` ASC) VISIBLE);
  CREATE TABLE IF NOT EXISTS `mydb`.`Entrenadores` (
  `ID` VARCHAR(255) NOT NULL,
  `email` VARCHAR(16) NOT NULL,
  `especializacion` VARCHAR(32) NOT NULL,
  `nombre y apellido` VARCHAR(100) NOT NULL,
  `telefono` VARCHAR(12) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `telefono_UNIQUE` (`telefono` ASC) VISIBLE);
  CREATE TABLE IF NOT EXISTS `mydb`.`Clases` (
  `ID` VARCHAR(32) NOT NULL,
  `capacidad` VARCHAR(100) NULL,
  `tipo de actividad` VARCHAR(45) NOT NULL,
  `horario` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC) VISIBLE,
  UNIQUE INDEX `horario_UNIQUE` (`horario` ASC) VISIBLE,
  UNIQUE INDEX `tipo de actividad_UNIQUE` (`tipo de actividad` ASC) VISIBLE);
  CREATE TABLE IF NOT EXISTS `mydb`.`Asistencia` (
  `ID` VARCHAR(16) NOT NULL,
  `fecha` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC) VISIBLE);
  CREATE TABLE IF NOT EXISTS `mydb`.`Equipamiento` (
  `nombre` VARCHAR(16) NOT NULL,
  `tipo` VARCHAR(255) NOT NULL);
  CREATE TABLE IF NOT EXISTS `mydb`.`Sucursales` (
  `direccion` VARCHAR(16) NOT NULL,
  `telefono` VARCHAR(25) NULL,
  UNIQUE INDEX `direccion_UNIQUE` (`direccion` ASC));CREATE TABLE IF NOT EXISTS `mydb`.`Planes de Entrenamiento` (
  `objetivo` VARCHAR(16) NOT NULL,
  PRIMARY KEY (`objetivo`),
  UNIQUE INDEX `objetivo_UNIQUE` (`objetivo` ASC) VISIBLE);
  
  
  
  
  
