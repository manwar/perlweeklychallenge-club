--
-- Perl Weekly Challenge 331
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-331>
--

CREATE SCHEMA IF NOT EXISTS pwc331;

CREATE OR REPLACE FUNCTION
pwc331.task2_plpgsql( l text, r text)
RETURNS boolean
AS $CODE$
DECLARE
	diffs int := 0;
BEGIN
	IF l = r THEN
	   RETURN true;
	END IF;

	IF length( l ) != length( r ) THEN
	   RETURN false;
	END IF;

	WITH
	lt AS (
	     SELECT lc::text, row_number() over () as lr
	     FROM regexp_split_to_table( l, '' ) lc
	)
	, rt AS (
	     SELECT rc::text, row_number() over () as rr
	     FROM regexp_split_to_table( r, '' ) rc
	)
	SELECT count(*)
	into diffs
	FROM lt, rt
	WHERE rr = lr
	AND lc <> rc
	;

	IF diffs > 2 THEN
	   RETURN false;
	ELSE
	   RETURN true;
	END IF;

END
$CODE$
LANGUAGE plpgsql;
