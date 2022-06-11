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
pwc158.cuban( v bigint )
RETURNS bigint
AS $CODE$
   SELECT pow( v + 1, 3 ) - pow( v, 3 );
$CODE$
LANGUAGE sql;



SELECT pwc158.cuban( v )
FROM generate_series( 1, 100 ) v
WHERE pwc158.is_prime( pwc158.cuban( v ) )
;
