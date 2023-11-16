--
-- Perl Weekly Challenge 243
-- Task 1
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-243/>
--

CREATE SCHEMA IF NOT EXISTS pwc243;

CREATE OR REPLACE FUNCTION
pwc243.task1_plpgsql( nums int[] )
RETURNS int
AS $CODE$
DECLARE
	c int := 0;
BEGIN
	FOR i IN 1 .. array_length( nums, 1 ) LOOP
	    FOR j IN i + 1 .. array_length( nums, 1 ) LOOP
	    	IF nums[ i ] > nums[ j ] * 2 THEN
		   c := c + 1;
		END IF;
	    END LOOP;
	END LOOP;

	RETURN c;
END
$CODE$
LANGUAGE plpgsql;
