/* Aqui se inicia la división de la tabla general en varias mas especificas*/
-- Verificar tabla general
SELECT * FROM trafico_maritimo;
SELECT TIPO_CARGA, EXPORTACION, IMPORTACIÓN, AÑO_VIGENCIA FROM trafico_maritimo;
SELECT PROVINCIA_ID, TIPO_CARGA, EXPORTACION, IMPORTACIÓN, AÑO_VIGENCIA FROM PROVINCIA INNER JOIN trafico_maritimo ON PROVINCIA.ZONA_PORTUARIA = trafico_maritimo.ZONA_PORTUARIA;

-- Creación tabla puerto a partir de la original
CREATE TABLE CARGA SELECT PROVINCIA_ID, TIPO_CARGA, EXPORTACION, IMPORTACIÓN, AÑO_VIGENCIA FROM PROVINCIA INNER JOIN trafico_maritimo ON PROVINCIA.ZONA_PORTUARIA = trafico_maritimo.ZONA_PORTUARIA;
SELECT * FROM CARGA;

-- Agregar columna id
ALTER TABLE CARGA ADD CARGA_ID INT NOT NULL auto_increment PRIMARY KEY;

-- Verficiar tabla nueva
SELECT * FROM CARGA;

-- Cambiar de lugar la columna id
ALTER TABLE CARGA MODIFY COLUMN CARGA_ID INT AFTER PROVINCIA_ID;

-- Agregar referencia a tabla provincia
ALTER TABLE CARGA ADD CONSTRAINT FK_PROVINCIA_ID_2 FOREIGN KEY (PROVINCIA_ID) REFERENCES PROVINCIA (PROVINCIA_ID);