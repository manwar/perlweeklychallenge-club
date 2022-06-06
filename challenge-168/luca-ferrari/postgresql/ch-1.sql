-- Perl Weekly Challenge 168
-- Task 1

CREATE SCHEMA IF NOT EXISTS pwc168;

CREATE OR REPLACE FUNCTION
pwc168.is_prime( n bigint )
RETURNS bool
AS $CODE$
DECLARE
        i bigint;
BEGIN
        FOR i IN 2 .. n - 1 LOOP
            IF n % i = 0 THEN
               RETURN FALSE;
            END IF;
        END LOOP;

        RETURN TRUE;
END
$CODE$
LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION
pwc168.task1_plpgsql( l bigint default 5000 )
RETURNS SETOF BIGINT
AS $CODE$
DECLARE
        a bigint;
        b bigint;
        c bigint;
        d bigint;
BEGIN
        -- bootstrap
        a := 3;
        b := 0;
        c := 2;

        RETURN NEXT a;
        RETURN NEXT b;
        RETURN NEXT c;

        WHILE l > 0 LOOP
           d := a + b;
           a := b;
           b := c;
           c := d;

           RAISE INFO 'Level % value %', l, c;
           RETURN NEXT c;
           l := l - 1;
       END LOOP;


RETURN;
END
$CODE$
LANGUAGE plpgsql;


-- use more than 50 to get all the numbers
-- BUT THIS CAN BE VERY SLOW from 70 and beyond!
SELECT DISTINCT n
FROM pwc168.task1_plpgsql( 50 ) n
WHERE pwc168.is_prime( n )
ORDER BY 1
LIMIT 13;
