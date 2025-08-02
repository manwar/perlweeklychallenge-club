--
-- Perl Weekly Challenge 267
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-267>
--

CREATE SCHEMA IF NOT EXISTS pwc267;

CREATE OR REPLACE FUNCTION
pwc267.task1_plpgsql( nums int[] )
RETURNS int
AS $CODE$
DECLARE
	i int;
	product int;
BEGIN
	product := 1;

	FOREACH i IN ARRAY nums LOOP
		product := product * i;
		IF product = 0 THEN
		   RETURN 0;
		END IF;
	END LOOP;

	IF product > 0 THEN
	   RETURN 1;
	ELSE
          RETURN -1;
	END IF;

END
$CODE$
LANGUAGE plpgsql;
