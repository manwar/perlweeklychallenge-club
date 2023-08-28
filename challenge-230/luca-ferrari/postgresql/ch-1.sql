--
-- Perl Weekly Challenge 230
-- Task 1
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-230/>
--

CREATE SCHEMA IF NOT EXISTS pwc230;

CREATE OR REPLACE FUNCTION
pwc230.task1_plpgsql( nums int[] )
RETURNS SETOF int
AS $CODE$
DECLARE
	n int;
	nn text;
BEGIN
	FOREACH n IN ARRAY nums LOOP
		FOREACH nn IN ARRAY regexp_split_to_array( n::text, '' ) LOOP
			RETURN NEXT nn::int;
		END LOOP;
	END LOOP;
END
$CODE$
LANGUAGE plpgsql;
