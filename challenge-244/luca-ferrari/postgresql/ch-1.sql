--
-- Perl Weekly Challenge 244
-- Task 1
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-244/>
--

CREATE SCHEMA IF NOT EXISTS pwc244;

CREATE OR REPLACE FUNCTION
pwc244.task1_plpgsql( nums int[] )
RETURNS SETOF int
AS $CODE$
DECLARE
	v int;
	returning int;
BEGIN
	FOREACH v IN ARRAY nums LOOP
		SELECT count(*)
		INTO returning
		FROM unnest( nums ) n
		WHERE n > v;

		RETURN NEXT returning;
	END LOOP;

	RETURN;
END
$CODE$
LANGUAGE plpgsql;
