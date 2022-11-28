-- Perl Weekly Challenge 193
-- Task 1

CREATE SCHEMA IF NOT EXISTS pwc193;

CREATE OR REPLACE FUNCTION
pwc193.task1_plpgsql( n int )
RETURNS SETOF TEXT
AS $CODE$
DECLARE
	i int;
BEGIN
	FOR i IN 0 .. pow( 2, n ) - 1 LOOP
	    RETURN NEXT i::bit( 24 )::text;
	END LOOP;

	RETURN;
END
$CODE$
LANGUAGE plpgsql;
