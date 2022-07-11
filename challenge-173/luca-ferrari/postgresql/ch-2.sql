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
