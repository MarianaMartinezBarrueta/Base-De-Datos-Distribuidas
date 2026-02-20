
/* Martínez Barrueta Mariana*/
/* TAREA 2: consulta con with*/
/* El with se usa para crear una tabla temporal logica que solo existe en una consulta 
y no se guarda en la base de datos ni en tabla fisica
*/
use escuela; 

WITH R as
(SELECT DISTINCT c.boleta, c.clave
    FROM escuela.cursa c
    JOIN escuela.Imparte i
      ON c.clave = i.clave
    WHERE i.numEmpleado = 'P0000001'
      AND c.calif >= 6),
S as(
SELECT DISTINCT clave
FROM escuela.Imparte
WHERE numEmpleado = 'P0000001'),

RXS as(
SELECT a.boleta, s.clave
    FROM (SELECT DISTINCT boleta FROM R) a
    CROSS JOIN S),

RXS_R as(
   SELECT tc.boleta, tc.clave
    FROM RXS tc
  where not exists (select 1
                    from R
            where tc.boleta = r.boleta 
            AND tc.clave = r.clave))
SELECT boleta
FROM R
EXCEPT
SELECT boleta 
FROM RXS_R;