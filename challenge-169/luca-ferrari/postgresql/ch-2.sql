-- Perl Weekly Challenge 169
-- Task 2

CREATE SCHEMA IF NOT EXISTS pwc169;

CREATE OR REPLACE FUNCTION
pwc169.task2_plpgsql( n int DEFAULT 20 )
RETURNS SETOF INT
AS $CODE$
DECLARE
        i int;
        current_min int;
        current_gcd int;
        previous_gcd int;
BEGIN

        FOR i IN 1 .. 999999 LOOP

           WITH bag AS (
                SELECT f, count(*) AS counter
                FROM pwc169.compute_factors( i ) f
                GROUP BY f
           )
           SELECT min( counter )
           INTO current_min
           FROM bag
           ;

           IF current_min < 2 THEN
              CONTINUE;
           END IF;

           previous_gcd := -1;
           FOR current_gcd IN  SELECT count(f) FROM pwc169.compute_factors( i ) f GROUP BY f LOOP
               IF previous_gcd < 0 THEN
                  previous_gcd := current_gcd;
                  CONTINUE;
               END IF;

               previous_gcd := gcd( previous_gcd, current_gcd );
           END LOOP;

           IF previous_gcd = 1 THEN
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
