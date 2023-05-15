--
-- Perl Weekly Challenge 215
-- Task 2
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-215/>
--

CREATE SCHEMA IF NOT EXISTS pwc215;

CREATE OR REPLACE FUNCTION
pwc215.task2_plpgsql( c int, digits int[] )
RETURNS boolean
AS $CODE$
DECLARE
	done boolean;
	i    int;
BEGIN
	i := 2;
	WHILE c > 0 LOOP
	      done := false;

	     WHILE i < array_length( digits, 1 )  LOOP
	     	 IF digits[ i ] = 0 AND digits[ i - 1 ] = 0 AND  digits[ i + 1 ] = 0 THEN
		    digits[ i ] := 1;
		    done := true;
		    c := c - 1;
		    EXIT;
		 END IF;

		 i := i + 1;
	     END LOOP;


	     IF NOT done THEN
	     	EXIT;
	     END IF;
	END LOOP;

	IF c = 0 THEN
	   RETURN true;
	ELSE
	   RETURN false;
	END IF;
END
$CODE$
LANGUAGE plpgsql;
