--
-- Perl Weekly Challenge 309
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-309>
--

CREATE SCHEMA IF NOT EXISTS pwc309;

CREATE OR REPLACE FUNCTION
pwc309.task2_plpgsql( nums int[] )
RETURNS int
AS $CODE$
DECLARE

	diff int;
	current_diff int;
	l int;
	r int;
BEGIN
	FOR l IN SELECT v FROM unnest( nums ) v LOOP
	    for r IN SELECT v FROM unnest( nums ) v LOOP
	    	IF r = l THEN
		   CONTINUE;
		END IF;

	    	current_diff := r - l;
		IF current_diff < 0 THEN
		   current_diff := current_diff * -1;
		END IF;

		IF diff IS NULL OR current_diff < diff THEN
		   diff := current_diff;
		END IF;
	    END LOOP;

	END LOOP;

	RETURN diff;

END
$CODE$
LANGUAGE plpgsql;
