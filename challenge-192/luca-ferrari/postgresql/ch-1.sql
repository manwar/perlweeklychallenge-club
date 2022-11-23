-- Perl Weekly Challenge 192
-- Task 1

CREATE SCHEMA IF NOT EXISTS pwc192;

CREATE OR REPLACE FUNCTION
pwc192.task1_plpgsql( n int )
RETURNS int
AS $CODE$
DECLARE
	bb text;
	b  bit;
BEGIN
	bb := '0'; -- needed for the conversion
	FOREACH b IN ARRAY regexp_split_to_array( n::bit(8)::text, '' )  LOOP
		IF b  THEN
		   bb := bb || 0;
		ELSE
		    bb := bb || 1;
		END IF;
	END LOOP;

	RAISE INFO '%', bb;
	RETURN bb::bit(8)::int;
END
$CODE$
LANGUAGE plpgsql;
