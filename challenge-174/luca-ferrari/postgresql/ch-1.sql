-- Perl Weekly Challenge 174
-- Task 1

CREATE SCHEMA IF NOT EXISTS pwc174;

CREATE OR REPLACE FUNCTION
pwc174.task1_plpgsql( l int DEFAULT 19 )
RETURNS SETOF BIGINT
AS $CODE$
DECLARE
        i int;
        v bigint;
        n bigint;
        s bigint;
BEGIN
        FOR n IN 10 .. 999999 LOOP
            i := 1;
            s := 0;

            FOR v IN SELECT * FROM regexp_split_to_table( n::text, '' ) LOOP
                s := s + pow( v::bigint, i );
                i := i + 1;
            END LOOP;

            IF s = n THEN
               l := l - 1;
               RETURN NEXT n;
            END IF;

            IF l <= 0 THEN
               EXIT;
            END IF;
        END LOOP;
RETURN;
END
$CODE$
LANGUAGE plpgsql;


-- single query approach
WITH digits AS
(
   SELECT v, digits.*, pow( digits.d, digits.rn) AS p
   FROM generate_series( 10, 99999 ) v
   , LATERAL ( SELECT d::bigint, row_number() over () AS rn
       FROM regexp_split_to_table( v::text, '') d
     ) digits

)
, comparison AS
(
   SELECT v, sum( p ) as s
   FROM digits
   GROUP BY v
)
SELECT *
FROM comparison
WHERE v = s
ORDER BY v
;
