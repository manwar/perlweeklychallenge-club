--
-- Perl Weekly Challenge 358
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-358>
--

CREATE SCHEMA IF NOT EXISTS pwc358;

CREATE OR REPLACE FUNCTION
pwc358.task1_plpgsql( s text[] )
RETURNS int
AS $CODE$
DECLARE
	value int := 0;
	ok boolean := false;
	computed int := 0;
	cur text;
BEGIN

	FOREACH cur IN ARRAY s LOOP
		SELECT v IS NOT NULL
		INTO ok
		FROM regexp_matches( cur, '^\d+$' ) v;

		IF ok THEN
		   computed = cur::int;
		ELSE
		   computed = length( cur );
		END IF;

		IF computed > value THEN
		   value := computed;
		END IF;

	END LOOP;

	RETURN value;

END
$CODE$
LANGUAGE plpgsql;
