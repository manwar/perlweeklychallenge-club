-- Perl Weekly Challenge 177
-- Task 2

CREATE SCHEMA IF NOT EXISTS pwc177;

CREATE OR REPLACE FUNCTION
pwc177.task2_plpgsql( l int default 20 )
RETURNS SETOF INT
AS $CODE$
DECLARE
        i int;
BEGIN
        FOR i IN 100 .. 99999 LOOP
            IF i::text <> reverse( i::text ) THEN
               -- not palindrome
               CONTINUE;
            END IF;

            IF length( i::text ) % 2 = 0 THEN
               -- even length
               CONTINUE;
            END IF;

            IF substring( i::text, length( i::text ) / 2 + 1, 1 ) <> '0' THEN
               CONTINUE;
            END IF;

            RETURN NEXT i;
            l := l - 1;
            EXIT WHEN l = 0;

        END LOOP;

RETURN;
END
$CODE$
LANGUAGE plpgsql;
