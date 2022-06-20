-- Perl Weekly Challenge 170
-- Task 1

CREATE SCHEMA IF NOT EXISTS pwc170;

CREATE OR REPLACE FUNCTION
pwc170.is_prime( v bigint )
RETURNS bool
AS $code$
DECLARE
        i bigint;
BEGIN
        FOR i IN  2 .. v - 1  LOOP
            IF v % i = 0 THEN
               RETURN false;
            END IF;
        END LOOP;

        RETURN TRUE;
END
$code$
LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION
pwc170.task1_plpgsql( l int default 10 )
RETURNS SETOF INT
AS $CODE$
DECLARE
        v bigint := 1;
        i bigint;
BEGIN
        FOR i IN SELECT n FROM generate_series( 1, 100000 ) n LOOP
            IF pwc170.is_prime( i ) THEN
               v := v * i;
               l := l - 1;
               RETURN NEXT v;
            END IF;

            IF l <= 0 THEN
               RETURN;
            END IF;
        END LOOP;

        RETURN;
END
$CODE$
LANGUAGE plpgsql;
