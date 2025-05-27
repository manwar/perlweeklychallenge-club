--
-- Perl Weekly Challenge 323
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-323>
--

CREATE SCHEMA IF NOT EXISTS pwc323;

CREATE OR REPLACE FUNCTION
pwc323.task1_plpgsql( operations text[] )
RETURNS int
AS $CODE$
DECLARE
	v int := 0;
	current text;
BEGIN

	FOREACH current IN ARRAY operations LOOP
		IF regexp_like( current, '\+\+' ) THEN
		   v := v + 1;
		ELSIF regexp_like( current, '\-\-' ) THEN
		   v := v - 1;
		END IF;
	END LOOP;

	RETURN v;
END
$CODE$
LANGUAGE plpgsql;
