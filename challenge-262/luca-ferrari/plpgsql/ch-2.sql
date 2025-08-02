--
-- Perl Weekly Challenge 262
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-262>
--

CREATE SCHEMA IF NOT EXISTS pwc262;

CREATE OR REPLACE FUNCTION
pwc262.task2_plpgsql( k int, nums int[] )
RETURNS int
AS $CODE$
DECLARE
	pairs_count int := 0;
BEGIN
	FOR i IN 1 .. array_length( nums, 1 )  LOOP
	    FOR j IN ( i + 1 ) .. array_length( nums, 1 )  LOOP
	    	IF nums[ i ] <> nums[ j ] THEN
		   CONTINUE;
		END IF;

		IF mod( i * j, k ) <> 0 THEN
		   CONTINUE;
		END IF;

		pairs_count := pairs_count + 1;
	    END LOOP;
	END LOOP;

	RETURN pairs_count;
END
$CODE$
LANGUAGE plpgsql;
