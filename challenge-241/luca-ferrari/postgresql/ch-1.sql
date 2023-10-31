--
-- Perl Weekly Challenge 241
-- Task 1
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-241/>
--

CREATE SCHEMA IF NOT EXISTS pwc241;

CREATE OR REPLACE FUNCTION
pwc241.task1_plpgsql( nums int[], diff int )
RETURNS int
AS $CODE$
DECLARE
	counter int := 0;
BEGIN
	FOR i IN 1 .. array_length( nums, 1 ) LOOP
	    FOR j IN ( i + 1 ) .. array_length( nums, 1 ) LOOP
	    	FOR k IN ( j + 1 ) .. array_length( nums, 1 ) LOOP
		    IF ( nums[ k ] - nums[ j ] ) = ( nums[ j ] - nums[ i ] ) AND ( nums[ k ] - nums[ j ] = diff ) THEN
		       counter := counter + 1;
		    END IF;
		END LOOP;
	    END LOOP;
	END LOOP;

	RETURN counter;
END
$CODE$
LANGUAGE plpgsql;
