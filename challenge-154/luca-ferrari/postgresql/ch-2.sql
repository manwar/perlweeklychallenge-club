CREATE SCHEMA IF NOT EXISTS pwc154;

CREATE OR REPLACE FUNCTION
pwc154.padovan( i int )
RETURNS int
AS $CODE$
BEGIN
        IF i <= 2 THEN
           RETURN 1;
        END IF;

        RETURN pwc154.padovan( i - 3 ) + pwc154.padovan( i - 2 );
END
$CODE$
LANGUAGE plpgsql;

/**
p
----
1
2
3
4
5
7
9
12
16
21
(10 rows)
*/
WITH
padovan_20 AS (
   SELECT n, pwc154.padovan( n ) AS p
   FROM generate_series( 0, 20 ) n
)
SELECT distinct( p.p )
FROM padovan_20 p
ORDER BY 1
LIMIT 10;
