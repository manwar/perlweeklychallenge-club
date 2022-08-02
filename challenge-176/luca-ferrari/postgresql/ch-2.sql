-- Perl Weekly Challenge 176
-- Task 2

CREATE SCHEMA IF NOT EXISTS pwc176;

CREATE OR REPLACE FUNCTION
pwc176.task2_plpgsql( l int default 100 )
RETURNS SETOF INT
AS $CODE$
DECLARE
        i int;
        s int;
        c int;
BEGIN

        FOR i IN 1 .. l LOOP
            s := i + reverse( i::text )::int;
            c := 0;

            SELECT count( v )
            INTO c
            FROM regexp_split_to_table( s::text, '' ) v
            WHERE v::int % 2 = 0;

            IF c = 0 THEN
               RETURN NEXT i;
            END IF;
        END LOOP;

RETURN;
END
$CODE$
LANGUAGE plpgsql;
