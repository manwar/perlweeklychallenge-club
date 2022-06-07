-- Perl Weekly Challenge 168
-- Task 2

CREATE SCHEMA IF NOT EXISTS pwc168;

CREATE OR REPLACE FUNCTION
pwc168.task2_prime_factors( n int )
RETURNS SETOF int
AS $CODE$
DECLARE
        i int;
        p bool;
BEGIN

        FOR i IN 2 .. n - 1 LOOP
            p := pwc168.is_prime( i );

            IF p AND n % i = 0  THEN
               WHILE n % i = 0 LOOP
                     n := n / i;
                     RETURN NEXT i;
               END LOOP;
            END IF;
        END LOOP;

RETURN;
END
$CODE$
LANGUAGE plpgsql;


/*
testdb=> select * from pwc168.task2_plpgsql( 10 );
task2_plpgsql
---------------
773

*/

CREATE OR REPLACE FUNCTION
pwc168.task2_plpgsql( n int DEFAULT 10 )
RETURNS int
AS $CODE$
DECLARE
        i int;
        v text;
        p bool;
BEGIN
        v = '0';
        FOR i IN SELECT * FROM pwc168.task2_prime_factors( n ) LOOP
            v := v || i;
        END LOOP;


        p := pwc168.is_prime( v::int );

        WHILE NOT p LOOP
                i := v::int;
                v = '0';
                FOR i IN SELECT * FROM pwc168.task2_prime_factors( i ) LOOP
                    v := v || i;
                END LOOP;
                p := pwc168.is_prime( v::int );
        END LOOP;

        RETURN v::int;
END
$CODE$
LANGUAGE plpgsql;
