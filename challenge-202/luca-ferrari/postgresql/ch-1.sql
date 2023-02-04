--
-- Perl Weekly Challenge 202
-- Task 1
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-202/>
--

CREATE SCHEMA IF NOT EXISTS pwc202;

CREATE OR REPLACE FUNCTION
pwc202.task1_plpgsql( l int[] )
RETURNS int
AS $CODE$
DECLARE
	odds int[];
	cur int;
BEGIN
	FOREACH cur IN ARRAY l LOOP
		IF cur % 2 = 0 THEN
		   CONTINUE;
		END IF;

		IF array_length( odds, 1 ) = 0 OR odds IS NULL THEN
		   odds := odds || cur;
		   CONTINUE;
		END IF;

		IF odds[ array_length( odds, 1 ) ] + 2 <> cur THEN
		   CONTINUE;
		END IF;

   	        odds := odds || cur;
	END LOOP;

	IF array_length( odds, 1 ) >= 3 THEN
	   RETURN 1;
	ELSE
	  RETURN 0;
	END IF;
END
$CODE$
LANGUAGE plpgsql;
