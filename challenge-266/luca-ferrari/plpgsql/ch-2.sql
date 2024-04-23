--
-- Perl Weekly Challenge 266
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-266>
--

CREATE SCHEMA IF NOT EXISTS pwc266;

CREATE OR REPLACE FUNCTION
pwc266.task2_plpgsql( s int, matrix int[] )
RETURNS boolean
AS $CODE$
DECLARE
	w int := 0;
BEGIN


	FOR r IN 1 .. s LOOP
	    FOR c IN 1 .. s LOOP
	    	w = ( r - 1 ) * s + c;
	    	IF r = c OR c = s - r + 1 THEN
		   IF matrix[ w ] = 0 THEN
		      RETURN false;
		   END IF;
		ELSE
		   IF matrix[ w ] <> 0 THEN
		      RETURN false;
		   END IF;
		END IF;

	    END LOOP;
	END LOOP;

	RETURN true;

END
$CODE$
LANGUAGE plpgsql;
