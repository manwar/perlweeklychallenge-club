--
-- Perl Weekly Challenge 234
-- Task 2
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-234/>
--

CREATE SCHEMA IF NOT EXISTS pwc234;

CREATE OR REPLACE FUNCTION
pwc234.task2_plpgsql( nums int[] )
RETURNS TABLE (ii int, jj int, kk int )
AS $CODE$
BEGIN
	FOR i IN 1 .. array_length( nums, 1 ) - 2 LOOP
	    FOR j IN i + 1 .. array_length( nums, 1 ) - 1 LOOP
	    	FOR k IN j + 1 .. array_length( nums, 1 ) LOOP
		    IF nums[i] <> nums[j] AND nums[j] <> nums[k] AND nums[k] <> nums[i] THEN
		       raise info '% % %', i, j, k;
		       ii := i;
		       jj := j;
		       kk := k;
		       RETURN NEXT;
		    END IF;
		END LOOP;
	    END LOOP;
	END LOOP;
END
$CODE$
LANGUAGE plpgsql;
