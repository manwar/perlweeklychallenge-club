--
-- Perl Weekly Challenge 226
-- Task 2
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-226/>
--

CREATE SCHEMA IF NOT EXISTS pwc226;

CREATE OR REPLACE FUNCTION
pwc226.task2_plpgsql( nums int[] )
RETURNS int
AS $CODE$
DECLARE
	moves int := 0;
	removing int := 0;
	i int;
BEGIN

	FOUND := true;

	WHILE FOUND LOOP
		-- get the nex min value
		SELECT min( n )
		INTO removing
		FROM unnest( nums ) n
		WHERE n > 0;

		-- stop (?)
		IF NOT FOUND OR removing IS NULL THEN
		   EXIT;
		ELSE
	           moves := moves + 1;
		END IF;

		FOR i IN 1 .. array_length( nums, 1 ) LOOP
		    IF nums[ i ] = 0 THEN
		       CONTINUE;
		    END IF;

		    nums[ i ] = nums[ i ] - removing;
		END LOOP;
	END LOOP;

	RETURN moves;
END
$CODE$
LANGUAGE plpgsql;
