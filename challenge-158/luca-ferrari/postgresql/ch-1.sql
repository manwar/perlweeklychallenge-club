CREATE SCHEMA IF NOT EXISTS pwc158;

CREATE OR REPLACE FUNCTION
pwc158.is_prime( v bigint )
RETURNS bool
AS $CODE$
DECLARE
i int;
BEGIN
FOR i IN  2 .. v - 1  LOOP
IF ( v % i = 0 ) THEN
RETURN false;
END IF;
END LOOP;

RETURN true;
END
$CODE$
LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION
pwc158.sum_digits( n bigint )
RETURNS int
AS $CODE$
   WITH s(i) AS ( SELECT regexp_split_to_table( n::text, '' ) )
   SELECT sum( i::bigint ) FROM s;
$CODE$
LANGUAGE SQL;


SELECT n
FROM generate_series( 1, 100 ) n
WHERE pwc158.is_prime( n )
AND pwc158.is_prime( pwc158.sum_digits( n ) );
