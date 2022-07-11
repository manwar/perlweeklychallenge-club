-- Perl Weekly Challenge 173
-- Task 2

CREATE SCHEMA IF NOT EXISTS pwc173;



CREATE OR REPLACE FUNCTION
pwc173.task2_plpgsql( n int default 10 )
RETURNS SETOF BIGINT
AS $CODE$
DECLARE
        product bigint;
BEGIN

        product := 2 * 3;
        RETURN NEXT 2;
        RETURN NEXT 3;
        n := n - 2;

        WHILE n > 0 LOOP
              RETURN NEXT ( product + 1 );
              product := ( product + 1 ) * product;
              n := n - 1;
        END LOOP;

RETURN;

END
$CODE$
LANGUAGE plpgsql;



-- query only result
WITH RECURSIVE numbers AS
(
        SELECT 2::numeric AS v, 0::numeric AS p, 1 AS r
        UNION
        SELECT 3 AS v, 6 as p, 2 AS r

        UNION

        SELECT p + 1, (p + 1) * p, r + 1
        FROM numbers
        WHERE p <> 0

)
SELECT v
FROM numbers
LIMIT 10;
