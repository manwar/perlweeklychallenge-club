-- Perl Weekly Challenge 199
-- Task 2

CREATE SCHEMA IF NOT EXISTS pwc199;

CREATE OR REPLACE FUNCTION
pwc199.task2_plpgsql( x int, y int, z int, l int[] )
RETURNS int
AS $CODE$
DECLARE
	i int;
	j int;
	k int;
	c int := 0;
BEGIN
	FOR i IN 1 .. array_length( l, 1 ) LOOP
	    FOR j IN ( i + 1 ) .. array_length( l, 1 ) LOOP
	    	FOR k IN ( j + 1 ) .. array_length( l, 1 ) LOOP
		    IF abs( l[i] - l[j] ) <= x AND abs( l[j] - l[k] ) <= y AND abs( l[i] - l[k] ) <= z THEN
		       c := c + 1;
		    END IF;
		END LOOP;
	    END LOOP;
	END LOOP;

	RETURN c;
END
$CODE$
LANGUAGE plpgsql;
