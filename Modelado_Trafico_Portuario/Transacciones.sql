/* Aqui se inicia la división de la tabla general en varias mas especificas*/
-- Verificar tabla general
SELECT * FROM trafico_maritimo;
SELECT TRANSBORDO, FLUVIAL, CABOTAJE, MOVILIZACIONES_BORDO, TRANSITORIA, AÑO_VIGENCIA FROM trafico_maritimo;
SELECT PROVINCIA_ID, TRANSBORDO, FLUVIAL, CABOTAJE, MOVILIZACIONES_BORDO, TRANSITORIA, AÑO_VIGENCIA FROM PROVINCIA INNER JOIN trafico_maritimo ON PROVINCIA.ZONA_PORTUARIA = trafico_maritimo.ZONA_PORTUARIA;

-- Creación tabla puerto a partir de la original
CREATE TABLE TRANSACCIONES SELECT PROVINCIA_ID, TRANSBORDO, FLUVIAL, CABOTAJE, MOVILIZACIONES_BORDO, TRANSITORIA, AÑO_VIGENCIA FROM PROVINCIA INNER JOIN trafico_maritimo ON PROVINCIA.ZONA_PORTUARIA = trafico_maritimo.ZONA_PORTUARIA;
SELECT * FROM TRANSACCIONES;

-- Agregar columna id
ALTER TABLE TRANSACCIONES ADD TRANSACCION_ID INT NOT NULL auto_increment PRIMARY KEY;

-- Verficiar tabla nueva
SELECT * FROM TRANSACCIONES;

-- Cambiar de lugar la columna id
ALTER TABLE TRANSACCIONES MODIFY COLUMN TRANSACCION_ID INT AFTER PROVINCIA_ID;

-- Agregar referencia a tabla provincia
ALTER TABLE TRANSACCIONES ADD CONSTRAINT FK_PROVINCIA_ID_3 FOREIGN KEY (PROVINCIA_ID) REFERENCES PROVINCIA (PROVINCIA_ID);