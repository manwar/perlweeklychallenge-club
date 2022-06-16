-- Perl Weekly Challenge 169
-- Task 1

CREATE SCHEMA IF NOT EXISTS pwc169;

CREATE OR REPLACE FUNCTION
pwc169.is_prime( n int )
RETURNS bool
AS $CODE$
DECLARE
        i int;
BEGIN
        FOR i IN 2 .. ( n - 1 ) LOOP
            IF n % i = 0 THEN
               RETURN FALSE;
            END IF;
        END LOOP;

        RETURN TRUE;
END
$CODE$
LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION
pwc169.compute_factors( n int )
RETURNS SETOF INT
AS $CODE$
DECLARE
        i int;
BEGIN

        FOR i IN 2 .. ( n - 1 ) LOOP
            IF NOT pwc169.is_prime( i ) THEN
               CONTINUE;
            END IF;

            WHILE n % i = 0 LOOP
                  RETURN NEXT i;
                  n = n / i;
            END LOOP;
        END LOOP;

RETURN;
END
$CODE$
LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION
pwc169.task1_plpgsql( n int DEFAULT 20 )
RETURNS SETOF INT
AS $CODE$
DECLARE
        i int;
        f int;
        current_length int := 0;
        current_count  int := 0;
        ok bool := false;
        previous_f     int := 0;
BEGIN

        FOR i IN 2 .. 100000 LOOP

            current_length := 0;
            current_count  := 0;
            ok             := true;
            previous_f     := 0;

            FOR f IN SELECT * FROM pwc169.compute_factors( i ) ORDER BY 1 LOOP

                current_count := current_count + 1;
                IF current_length = 0 THEN
                   current_length := length( f::text );
                END IF;

                IF length( f::text ) <> current_length OR current_count > 2 OR f = previous_f THEN
                   ok := false;
                   EXIT;
                END IF;

                previous_f := f;
            END LOOP;

            IF ok AND previous_f <> 0 THEN

               RETURN NEXT i;
               IF n = 0 THEN
                  RETURN;
               END IF;
               n := n - 1;
            END IF;
        END LOOP;

RETURN;
END
$CODE$
LANGUAGE plpgsql;
