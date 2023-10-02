--
-- Perl Weekly Challenge 235
-- Task 2
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-235/>
--

CREATE SCHEMA IF NOT EXISTS pwc235;

CREATE OR REPLACE FUNCTION
pwc235.task2_plpgsql( nums int[] )
RETURNS SETOF int
AS $CODE$
DECLARE
	current_element int;
	remaining int;
BEGIN
	remaining := array_length( nums, 1 );

	FOREACH current_element IN ARRAY nums LOOP
		RETURN NEXT current_element;
		remaining := remaining - 1;

		IF remaining = 0 THEN
		   RETURN;
		END IF;

		IF current_element = 0 THEN
		   RETURN NEXT 0;
		   remaining := remaining - 1;
		END IF;

		IF remaining = 0 THEN
		   RETURN;
		END IF;

	END LOOP;

RETURN;
END
$CODE$
LANGUAGE plpgsql;
