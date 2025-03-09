/* Aqui se inicia la división de la tabla general en varias mas especificas*/
-- Verificar tabla general
SELECT * FROM trafico_maritimo;
SELECT DISTINCT ZONA_PORTUARIA FROM trafico_maritimo;

-- Creación tabla provincia a partir de la original
CREATE TABLE PROVINCIA SELECT DISTINCT ZONA_PORTUARIA FROM trafico_maritimo;
SELECT * FROM PROVINCIA;

-- Agregar columna id
ALTER TABLE PROVINCIA ADD PUERTO_ID INT NOT NULL auto_increment PRIMARY KEY;
ALTER TABLE PROVINCIA CHANGE COLUMN PUERTO_ID PROVINCIA_ID INT ;

-- Verficiar tabla nueva
SELECT * FROM PROVINCIA;

-- Cambiar de lugar la columna id
ALTER TABLE PROVINCIA MODIFY COLUMN ZONA_PORTUARIA VARCHAR(50) AFTER PUERTO_ID;