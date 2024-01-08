--
-- Perl Weekly Challenge 250
-- Task 1
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-250/>
--

CREATE SCHEMA IF NOT EXISTS pwc250;

CREATE OR REPLACE FUNCTION
pwc250.task1_plpgsql( nums int[] )
RETURNS int
AS $CODE$
BEGIN
	FOR i IN 1 .. array_length( nums, 1 ) LOOP
	    IF  mod( i, 10 ) = nums[ i ] THEN
	    	RETURN i;
	    END IF;
	END LOOP;

	RETURN -1;
END
$CODE$
LANGUAGE plpgsql;
