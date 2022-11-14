-- Perl Weekly Challenge 191
-- Task 1

CREATE SCHEMA IF NOT EXISTS pwc191;

CREATE OR REPLACE FUNCTION
pwc191.task1_plpgsql( l int[] )
RETURNS int
AS $CODE$
DECLARE
	current_max int;
	wrong int := 0;
BEGIN
	-- compute the max
	SELECT max( v )
	INTO   current_max
	FROM unnest( l ) v;

	SELECT count(*)
	INTO   wrong
	FROM unnest( l ) v
	WHERE ( v * 2 ) > current_max
	AND   v <> current_max;

	IF wrong > 0 THEN
	   RETURN -1;
        ELSE
          RETURN 1;
        END IF;

END
$CODE$
LANGUAGE plpgsql;
