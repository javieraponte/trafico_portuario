/* Inicio del proceso de limpieza y corrección de datos */
-- Agrupar todas las empresas para verificar errores
SELECT SOCIEDAD_PORTUARIA 
FROM trafico_maritimo 
GROUP BY SOCIEDAD_PORTUARIA;

-- Cambiar error en la columna SOCIEDAD_PORTUARIA de COMPA�IA DE PUERTOS ASOCIADOS S.A. a COMPAÑIA DE PUERTOS ASOCIADOS S.A.
UPDATE trafico_maritimo 
SET SOCIEDAD_PORTUARIA = 'COMPAÑIA DE PUERTOS ASOCIADOS S.A.' 
WHERE SOCIEDAD_PORTUARIA = 'COMPA�IA DE PUERTOS ASOCIADOS S.A.';

-- Ahora a cambiar todos los errores en los registros de la columna SOCIEDAD_PORTUARIA
UPDATE trafico_maritimo 
SET SOCIEDAD_PORTUARIA = 'CENIT TRANSPORTE Y LOGISTICA DE HIDROCARBUROS SAS' 
WHERE SOCIEDAD_PORTUARIA = 'CENIT TRANSPORTE Y LOG�STICA DE HIDROCARBUROS SAS';
UPDATE trafico_maritimo SET SOCIEDAD_PORTUARIA = 'C.I. UNIÓN DE BANANEROS DE URABA - UNIBAN' 
WHERE SOCIEDAD_PORTUARIA = 'C.I. UNI�N DE BANANEROS DE URABA - UNIBAN';

-- Agrupar tipo carga para verificar errores
SELECT TIPO_CARGA 
FROM trafico_maritimo 
GROUP BY TIPO_CARGA;

-- Agrupar puerto para verificar errores
SELECT ZONA_PORTUARIA 
FROM trafico_maritimo 
GROUP BY ZONA_PORTUARIA;

/* Finaliza el proceso de limpieza y corrección de datos */


/* Inicia el proceso de consulta para los analisis del proyecto */
-- ¿Cual es el puerto con mayor trafico maritimo en los ultimos cinco años?
SELECT ZONA_PORTUARIA AS PUERTO, 
COUNT(ZONA_PORTUARIA) AS CANTIDAD 
FROM trafico_maritimo 
WHERE AÑO_VIGENCIA > '2019' 
GROUP BY ZONA_PORTUARIA 
ORDER BY COUNT(ZONA_PORTUARIA) DESC LIMIT 3;
-- R/ CARTAGENA CON 1981 TONELADAS EN LOS ULTIMOS CINCO AÑOS

-- ¿Cual es el tipo de carga con mas recurrencia en Cartagena y cual es su carga anual?
-- Carga más recurrente en Cartagena
SELECT TIPO_CARGA AS CARGA, 
COUNT(TIPO_CARGA) AS CONTEO 
FROM trafico_maritimo 
WHERE ZONA_PORTUARIA = 'CARTAGENA' 
GROUP BY TIPO_CARGA 
ORDER BY COUNT(TIPO_CARGA) DESC;
-- GRANEL LIQUIDO CON 1029 REGISTROS

-- Carga anual en Cartagena
SELECT ZONA_PORTUARIA AS PUERTO, TIPO_CARGA AS CARGA, AÑO_VIGENCIA AS AÑO, 
SUM(EXPORTACION) + SUM(IMPORTACIÓN) AS 'TOTAL TONELADAS' 
FROM trafico_maritimo 
WHERE ZONA_PORTUARIA = 'CARTAGENA' 
GROUP BY CARGA, AÑO 
ORDER BY AÑO_VIGENCIA DESC;

-- Unir carga más recurrente y carga anual
SELECT ZONA_PORTUARIA AS PUERTO, TIPO_CARGA AS CARGA, AÑO_VIGENCIA AS AÑO, 
SUM(EXPORTACION) + SUM(IMPORTACIÓN) AS TOTAL_TONELADAS 
FROM trafico_maritimo 
WHERE ZONA_PORTUARIA = 'CARTAGENA' AND TIPO_CARGA = 'GRANEL LIQUIDO' 
GROUP BY AÑO_VIGENCIA 
ORDER BY TOTAL_TONELADAS DESC;

-- ¿Cuanta carga se moviliza en cabotaje anual y que relación tiene con el trafico de carga expo/impo?
-- Cantidad de cabotaje por año
SELECT AÑO_VIGENCIA AS AÑO, 
SUM(CABOTAJE) AS 'CANTIDAD CABOTAJE' 
FROM trafico_maritimo 
GROUP BY AÑO_VIGENCIA 
ORDER BY AÑO_VIGENCIA DESC;

-- Cantidad exportación por año
SELECT AÑO_VIGENCIA AS AÑO, 
SUM(EXPORTACION) AS 'EXPO TOTAL' 
FROM trafico_maritimo 
GROUP BY AÑO_VIGENCIA 
ORDER BY AÑO_VIGENCIA DESC;

-- Cantidad importación por año
SELECT AÑO_VIGENCIA AS AÑO, 
SUM(IMPORTACIÓN) AS 'IMPO TOTAL' 
FROM trafico_maritimo 
GROUP BY AÑO_VIGENCIA 
ORDER BY AÑO_VIGENCIA DESC;

-- Cantidad expo/impo total por año
SELECT AÑO_VIGENCIA AS AÑO, 
SUM(EXPORTACION) AS 'EXP TOTAL', 
SUM(IMPORTACIÓN) AS 'IMP TOTAL' 
FROM trafico_maritimo 
GROUP BY AÑO_VIGENCIA 
ORDER BY AÑO_VIGENCIA DESC;

-- Union de cabotaje con cantidad total de expo/impo por año
SELECT AÑO_VIGENCIA AS AÑO, SUM(CABOTAJE) AS 'TOTAL CABOTAJE', 
SUM(EXPORTACION) AS 'EXP TOTAL', 
SUM(IMPORTACIÓN) AS 'IMP TOTAL' 
FROM trafico_maritimo 
GROUP BY AÑO_VIGENCIA 
ORDER BY AÑO_VIGENCIA DESC;

-- ¿Que porcentaje de carga es transitoria con respecto al trafico de carga expo/impo al año?
-- Este es el promedio
SELECT AÑO_VIGENCIA AS AÑO, AVG(TRANSITORIA) AS PROMEDIO, 
SUM(EXPORTACION) AS EXPO, 
SUM(IMPORTACIÓN) AS IMPO 
FROM trafico_maritimo 
GROUP BY AÑO_VIGENCIA
ORDER BY PROMEDIO DESC;

-- Query final
SELECT AÑO_VIGENCIA AS AÑO, 
CONCAT(ROUND(SUM(((TRANSITORIA / (SELECT SUM(TRANSITORIA) FROM trafico_maritimo)) * 100)),2), ' %') AS PORCENTAJE, 
SUM(EXPORTACION) AS EXPORTACION, 
SUM(IMPORTACIÓN) AS IMPORTACION 
FROM trafico_maritimo GROUP BY AÑO_VIGENCIA 
ORDER BY ROUND(PORCENTAJE) DESC;