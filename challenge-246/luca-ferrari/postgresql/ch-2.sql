--
-- Perl Weekly Challenge 246
-- Task 2
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-246/>
--

CREATE SCHEMA IF NOT EXISTS pwc246;

CREATE OR REPLACE FUNCTION
pwc246.task2_plpgsql( nums int[] )
RETURNS bool
AS $CODE$
DECLARE
	current_index int;
	p int;
	q int;
	ok bool := false;
	ko int;
BEGIN

	ko := array_length( nums, 1 ) - 3 + 1;

	FOR current_index IN 3 .. array_length( nums, 1 ) LOOP
	    ok := false;

	    FOR p IN 1 .. 99999 LOOP
	    	FOR q IN 1 .. 9999 LOOP
		    IF nums[ current_index ] = ( p * nums[ current_index - 2 ] + q * nums[ current_index - 1 ] )
		       OR nums[ current_index ] = ( p * -1 * nums[ current_index - 2 ] + q * nums[ current_index - 1 ] )
		       OR nums[ current_index ] = ( p * -1 * nums[ current_index - 2 ] + q * -1 *nums[ current_index - 1 ] )
		       OR nums[ current_index ] = ( p * nums[ current_index - 2 ] + q * -1 * nums[ current_index - 1 ] ) THEN
		       	  ok := true;
			  ko := ko - 1;
			  EXIT;
	            END IF;
		END LOOP;

		IF ok THEN
		   EXIT;
		END IF;

	    END LOOP;
	END LOOP;

	RETURN ko = 0;
END
$CODE$
LANGUAGE plpgsql;
