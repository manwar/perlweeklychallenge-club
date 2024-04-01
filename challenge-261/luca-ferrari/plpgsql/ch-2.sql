--
-- Perl Weekly Challenge 261
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-261>
--

CREATE SCHEMA IF NOT EXISTS pwc261;

CREATE OR REPLACE FUNCTION
pwc261.task2_plpgsql( s int, nums int[] )
RETURNS int
AS $CODE$
DECLARE

BEGIN
	LOOP
		PERFORM s
		FROM unnest( nums ) n
		WHERE n::int = s;

		IF FOUND THEN
		   s := s * 2;
		ELSE
		  RETURN s;
		END IF;
	END LOOP;

END
$CODE$
LANGUAGE plpgsql;
