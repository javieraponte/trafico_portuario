/* Aqui se inicia la división de la tabla general en varias mas especificas*/
-- Verificar tabla general
SELECT * FROM trafico_maritimo;
SELECT DISTINCT PROVINCIA_ID, SOCIEDAD_PORTUARIA, TIPO_SERVICIO FROM PROVINCIA INNER JOIN trafico_maritimo ON PROVINCIA.ZONA_PORTUARIA = trafico_maritimo.ZONA_PORTUARIA;

-- Creación tabla puerto a partir de la original
CREATE TABLE PUERTO SELECT DISTINCT PROVINCIA_ID, SOCIEDAD_PORTUARIA, TIPO_SERVICIO FROM PROVINCIA INNER JOIN trafico_maritimo ON PROVINCIA.ZONA_PORTUARIA = trafico_maritimo.ZONA_PORTUARIA;

-- Agregar columna id
ALTER TABLE PUERTO ADD PUERTO_ID INT NOT NULL auto_increment PRIMARY KEY;

-- Verficiar tabla nueva
SELECT * FROM PUERTO;

-- Cambiar de lugar la columna id
ALTER TABLE PUERTO MODIFY COLUMN PUERTO_ID INT AFTER PROVINCIA_ID;

-- Agregar referencia a tabla provincia
ALTER TABLE PUERTO ADD CONSTRAINT FK_PROVINCIA_ID FOREIGN KEY (PROVINCIA_ID) REFERENCES PROVINCIA (PROVINCIA_ID);