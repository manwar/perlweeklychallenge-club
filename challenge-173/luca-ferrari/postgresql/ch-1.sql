-- Perl Weekly Challenge 173
-- Task 1

CREATE SCHEMA IF NOT EXISTS pwc173;



CREATE OR REPLACE FUNCTION
pwc173.task1_plpgsql( n int )
RETURNS BOOL
AS $CODE$
DECLARE
        d text;
        previous int := -1;
BEGIN
        FOR d IN SELECT regexp_split_to_table( n::text, '' ) LOOP
            IF previous = -1 THEN
               previous = d::int;
               CONTINUE;
            END IF;

            IF abs( previous - d::int ) != 1 THEN
               RETURN FALSE;
            ELSE
                previous = d::int;
            END IF;
        END LOOP;

RETURN TRUE;
END
$CODE$
LANGUAGE plpgsql;



-- a single query approach
-- returns true if the number is esthetic
WITH nums AS
(
        SELECT v::int, v::int - lag( v::int, 1, 0 ) OVER () AS diff
        FROM regexp_split_to_table( 12345::text, '' ) v
)
SELECT NOT EXISTS(
       SELECT *
       FROM nums
       WHERE abs( diff ) <> 1
);
