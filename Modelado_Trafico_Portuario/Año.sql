/* Aqui se inicia la división de la tabla general en varias mas especificas*/
-- Verificar tabla general
SELECT * FROM trafico_maritimo;
SELECT DISTINCT AÑO_VIGENCIA FROM trafico_maritimo;

-- Creación tabla provincia a partir de la original
CREATE TABLE AÑO SELECT DISTINCT AÑO_VIGENCIA FROM trafico_maritimo;
SELECT * FROM AÑO;

-- Agregar columna id
ALTER TABLE AÑO ADD AÑO_ID INT NOT NULL auto_increment PRIMARY KEY;

-- Verficiar tabla nueva
SELECT * FROM AÑO;

-- Cambiar de lugar la columna id
ALTER TABLE AÑO MODIFY COLUMN AÑO_VIGENCIA YEAR AFTER AÑO_ID;