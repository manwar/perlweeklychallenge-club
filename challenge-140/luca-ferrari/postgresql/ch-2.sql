CREATE OR REPLACE FUNCTION f_multiplication_table( i int, j int, k int )
RETURNS int
AS $CODE$

WITH RECURSIVE a AS (
     SELECT 1 as x
     UNION
     SELECT x + 1 FROM a
     WHERE  x < i
)
, b AS (
    SELECT 1 as y
    UNION
    SELECT y + 1 FROM b
    WHERE  y  < j
)
, product AS ( SELECT x * y FROM a, b ORDER BY 1 )

select * from product limit 1 offset k;

$CODE$
LANGUAGE SQL;
