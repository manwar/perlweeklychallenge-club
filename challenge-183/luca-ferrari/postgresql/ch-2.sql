-- Perl Weekly Challenge 183
-- Task 2

CREATE SCHEMA IF NOT EXISTS pwc183;

CREATE OR REPLACE FUNCTION
pwc183.task2_plpgsql( d1 date, d2 date )
RETURNS int[]
AS $CODE$
DECLARE
        days  int;
        years int;
BEGIN
        days := abs( d2 - d1 );

        IF days >= 365 THEN
           years := days / 365;
           days  := days % 365;
        ELSE
           years := 0;
        END IF;

        RETURN ARRAY[ years, days ]::int[];
END
$CODE$
LANGUAGE plpgsql;
