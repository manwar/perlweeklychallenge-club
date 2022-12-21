-- Perl Weekly Challenge 196
-- Task 2

CREATE SCHEMA IF NOT EXISTS pwc196;

CREATE OR REPLACE FUNCTION
pwc196.task2_plpgsql( l int[])
RETURNS SETOF int[]
AS $CODE$
DECLARE
	c_start int := 0;
	c_end   int := 0;
BEGIN

	FOR i IN 0 .. array_length( l, 1 ) LOOP
	    IF i < c_end THEN
	       CONTINUE;
	    END IF;

	    c_start := i;
	    c_end := c_start;

	    WHILE c_end < array_length( l, 1 ) AND l[ c_end + 1 ] = l[ c_end ] + 1 LOOP
	    	  c_end := c_end + 1;
	    END LOOP;

	    IF c_start < c_end THEN
	       RETURN NEXT ARRAY[ c_start, c_end ]::int[];
	    END IF;
	END LOOP;

RETURN;
END
$CODE$
LANGUAGE plpgsql;
