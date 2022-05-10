-- Perl Weekly Challenge 164
-- Task 2

CREATE SCHEMA IF NOT EXISTS pwc164;


CREATE OR REPLACE FUNCTION
pwc164.is_happy( n int )
RETURNS bool
AS $CODE$
DECLARE
        s  int;
        nn int;
BEGIN
        WHILE n > 10 LOOP
              s := 0;
              FOREACH nn IN ARRAY regexp_split_to_array( n::text, '' )::int[] LOOP
                s := s + nn * nn;
              END LOOP;

              n := s;

        END LOOP;

        IF n = 1 THEN
           RETURN true;
        ELSE
           RETURN false;
        END IF;
END
$CODE$
LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION
pwc164.task2_plpgsql( l int DEFAULT 8 )
RETURNS SETOF INT
AS $CODE$
DECLARE
BEGIN
        FOR n IN 10 .. 99999 LOOP
            IF pwc164.is_happy( n ) THEN
               RETURN NEXT n;
               l := l - 1;
            END IF;

            EXIT WHEN l = 0;
        END LOOP;

        RETURN;
END
$CODE$
LANGUAGE plpgsql;
