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

CREATE OR REPLACE FUNCTION
pwc154.is_prime( n int )
RETURNS bool
AS $CODE$
DECLARE
    i int;
BEGIN
    FOR i IN 2 .. n - 1 LOOP
        IF n % i = 0 THEN
           RETURN false;
        END IF;
    END LOOP;

    RETURN true;
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
padovan AS (
   SELECT n, pwc154.padovan( n ) AS p
   FROM generate_series( 0, 50 ) n
)
, padovan_prime
AS (
  SELECT p, pwc154.is_prime( p ) AS prime
  FROM padovan p
)
SELECT distinct( p )
FROM padovan_prime
WHERE prime
ORDER BY 1
LIMIT 10
;
