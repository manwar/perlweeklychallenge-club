--
-- Perl Weekly Challenge 243
-- Task 2
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-243/>
--

CREATE SCHEMA IF NOT EXISTS pwc243;

CREATE OR REPLACE FUNCTION
pwc243.task2_plpgsql( nums int[] )
RETURNS int
AS $CODE$
DECLARE
	s int := 0;
	current int;
BEGIN
	FOR i in 1 .. array_length( nums, 1 ) LOOP

	    FOREACH current IN ARRAY nums LOOP
	    	    s := s + ( nums[ i ] / current )::int;
	    END LOOP;
	END LOOP;

	RETURN s;
END
$CODE$
LANGUAGE plpgsql;
