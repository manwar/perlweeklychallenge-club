-- Perl Weekly Challenge 159


CREATE SCHEMA IF NOT EXISTS pwc159;


CREATE OR REPLACE FUNCTION
pwc159.farey_not_unique( n int )
RETURNS TABLE( f text, v numeric )
AS $CODE$
DECLARE
     numerator   int;
     denominator int;
     dd          int;
     nn          int;
BEGIN

        -- bootstrap term
        SELECT '0/1', 0
        INTO f, v;

        RETURN NEXT;


        FOR denominator IN 2 .. n  LOOP
            FOR numerator IN  1 .. denominator  LOOP
                nn := numerator;
                dd := denominator;

                IF dd % nn = 0 THEN
                   dd := dd / nn;
                   nn := 1;
                END IF;

                IF nn % dd = 0 THEN
                   nn := nn / dd;
                   dd := 1;
                END IF;

                IF nn / dd = 1 THEN
                   CONTINUE;
                END IF;

                SELECT nn || '/' || dd, nn/dd::numeric
                INTO  f, v;

                RETURN NEXT;

            END LOOP;
        END LOOP;

        -- end term
        SELECT '1/1', 1
        INTO f, v;

        RETURN NEXT;

RETURN;
END
$CODE$
LANGUAGE plpgsql;


WITH farey AS (
     SELECT distinct( f ), v
     FROM pwc159.farey_not_unique( 5 )
     ORDER BY v
)
SELECT f
FROM farey;
