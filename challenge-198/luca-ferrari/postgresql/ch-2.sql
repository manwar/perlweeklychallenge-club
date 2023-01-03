CREATE SCHEMA IF NOT EXISTS pwc198;

CREATE OR REPLACE FUNCTION
pwc198.is_prime( l int )
RETURNS bool
AS $CODE$
DECLARE
	i int;
BEGIN
	FOR i IN  2 .. l - 1 LOOP
	    IF l % i = 0 THEN
	       RETURN FALSE;
	    END IF;
	END LOOP;

	RETURN TRUE;
END
$CODE$
LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION
pwc198.task2_plpgsql( l int )
RETURNS int
AS $CODE$
DECLARE
	c int := 0;
	i int;
BEGIN
	FOR i IN 2 .. l LOOP
	    IF pwc198.is_prime( i ) THEN
	       c := c + 1;
	    END IF;
	END LOOP;

	RETURN c;
END
$CODE$
LANGUAGE plpgsql;
