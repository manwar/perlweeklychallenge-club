-- Perl Weekly Challenge 196
-- Task 1

CREATE SCHEMA IF NOT EXISTS pwc196;

CREATE OR REPLACE FUNCTION
pwc196.task1_plpgsql( l int[] )
RETURNS SETOF int[]
AS $CODE$
DECLARE
	last_index int := 0;
BEGIN

	FOR i IN 1 .. array_length(l,1) - 1 LOOP
	    IF i <= last_index THEN
	       CONTINUE;
	    END IF;

	    IF l[ i - 1 ] < l[ i ] AND l[ i ] < l[ i + 1 ] THEN
	       RETURN NEXT ARRAY[ l[i-1], l[i], l[i + 1] ]::int[];
	       last_index := i + 1;
	    END IF;
	END LOOP;
RETURN;
END
$CODE$
LANGUAGE plpgsql;
