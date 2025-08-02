--
-- Perl Weekly Challenge 287
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-287>
--

CREATE SCHEMA IF NOT EXISTS pwc287;

CREATE OR REPLACE FUNCTION
pwc287.task1_plpgsql( pwd text )
RETURNS bool
AS $CODE$
DECLARE
	counter int := 0;
BEGIN

	IF length( pwd ) < 6 THEN
	   RETURN false;
	END IF;

	SELECT count( x )
	INTO counter
	FROM regexp_matches( pwd, '[a-z]', 'g' ) x;

	IF counter <= 0 THEN
	   RETURN false;
	END IF;

	SELECT count( x )
	INTO counter
	FROM regexp_matches( pwd, '[A-Z]', 'g' ) x;

	IF counter <= 0 THEN
	   RETURN false;
	END IF;

	SELECT count( x )
	INTO counter
	FROM regexp_matches( pwd, '[0-9]', 'g' ) x;

	IF counter <= 0 THEN
	   RETURN false;
	END IF;


	SELECT count( x )
	INTO counter
	FROM regexp_matches( pwd, '(.)\1\1', 'g' ) x;

	IF counter > 0 THEN
	   RETURN false;
	END IF;


	RETURN true;
END
$CODE$
LANGUAGE plpgsql;
