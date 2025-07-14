--
-- Perl Weekly Challenge 330
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-330>
--

CREATE SCHEMA IF NOT EXISTS pwc330;

CREATE OR REPLACE FUNCTION
pwc330.task1_plpgsql( s text )
RETURNS text
AS $CODE$
DECLARE

BEGIN
	WHILE regexp_match( s, '[a-z][0-9]' ) IS NOT NULL LOOP
	      s := regexp_replace( s, '([a-z])([0-9])', '' );
	END LOOP;

	RETURN s;
END
$CODE$
LANGUAGE plpgsql;
