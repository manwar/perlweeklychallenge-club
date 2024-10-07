--
-- Perl Weekly Challenge 290
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-290>
--

CREATE SCHEMA IF NOT EXISTS pwc290;

CREATE OR REPLACE FUNCTION
pwc290.task1_plpgsql( nums int[] )
RETURNS boolean
AS $CODE$
DECLARE
	i int;
	j int;
	c int := 0;
BEGIN

	FOR i IN 1 .. array_length( nums, 1 ) - 1 LOOP
	    FOR j IN ( i + 1 ) .. array_length( nums, 1 ) LOOP
	    	IF nums[ i ] = ( nums[ j ] * 2 ) THEN
		   c := c + 1;
		END IF;
	    END LOOP;
	END LOOP;

	IF c > 0 THEN
	   RETURN true;
	ELSE
           RETURN false;
	END IF;

END
$CODE$
LANGUAGE plpgsql;
