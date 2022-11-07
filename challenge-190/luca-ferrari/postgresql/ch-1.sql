-- Perl Weekly Challenge 190
-- Task 1

CREATE SCHEMA IF NOT EXISTS pwc190;

CREATE OR REPLACE FUNCTION
pwc190.task1_plpgsql( word text )
RETURNS int
AS $CODE$
BEGIN
	IF word ~ '^[A-Z][a-z]+$' THEN
	   RETURN 1;
	ELSIF word ~ '^[a-z]+$' THEN
	   RETURN 1;
	ELSIF word ~ '^[A-Z]+$' THEN
	   RETURN 1;
	ELSE
	  RETURN 0;
	END IF;
END
$CODE$
LANGUAGE plpgsql;
