--
-- Perl Weekly Challenge 236
-- Task 2
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-236/>
--

CREATE SCHEMA IF NOT EXISTS pwc236;

CREATE OR REPLACE FUNCTION
pwc236.task2_plpgsql( nums int[] )
RETURNS int
AS $CODE$
DECLARE
	current_start int;
	loops int := 0;
	next int;
BEGIN

	FOR current_start in 1 .. array_length( nums, 1 ) LOOP
		next := nums[ current_start ];

		WHILE next >= 1 AND next <= array_length( nums, 1 ) LOOP
		      IF nums[ next ] = current_start THEN
		      	 loops := loops + 1;
			 EXIT;
		      END IF;

		      next := nums[ next ];
		END LOOP;
	END LOOP;

	RETURN loops;
END

$CODE$
LANGUAGE plpgsql;
