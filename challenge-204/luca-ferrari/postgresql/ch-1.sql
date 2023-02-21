--
-- Perl Weekly Challenge 204
-- Task 1
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-204/>
--

CREATE SCHEMA IF NOT EXISTS pwc204;

CREATE OR REPLACE FUNCTION
pwc204.task1_plpgsql( l int[] )
RETURNS int
AS $CODE$
DECLARE
   monotonic_mode bool;
   i int;
BEGIN

	FOR i IN 2 .. array_length( l, 1 )  LOOP
	    IF l[ i ] = l[ i - 1 ] THEN
	       CONTINUE;
	    END IF;

	    IF monotonic_mode IS NULL THEN
	       IF l[ i ] > l[ i - 1 ] THEN
	       	  monotonic_mode := true;
	       ELSE
	         monotonic_mode := false;
	       END IF;
	    END IF;

           IF monotonic_mode AND l[ i ] < l[ i - 1 ] THEN
	      RETURN 0;
	   END IF;
           IF NOT monotonic_mode AND l[ i ] > l[ i - 1 ] THEN
	      RETURN 0;
	   END IF;
	END LOOP;

	RETURN 1;
END
$CODE$
LANGUAGE plpgsql;
