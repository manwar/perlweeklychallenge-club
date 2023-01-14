-- Perl Weekly Challenge 199
-- Task 1

CREATE SCHEMA IF NOT EXISTS pwc199;

CREATE OR REPLACE FUNCTION
pwc199.task1_plpgsql( l int[] )
RETURNS int
AS $CODE$
DECLARE
	i int;
	j int;
	c int := 0;
BEGIN
	FOR i IN 1 .. array_length( l, 1 ) LOOP
	    FOR j IN i .. array_length( l , 1 ) LOOP
	    	If i = j THEN
		   CONTINUE;
		END IF;

		IF l[i] = l[j] THEN
		   c := c + 1;
		END IF;
	    END LOOP;
	END LOOP;

	RETURN c;
END
$CODE$
LANGUAGE plpgsql;
