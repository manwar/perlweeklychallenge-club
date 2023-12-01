--
-- Perl Weekly Challenge 245
-- Task 1
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-245/>
--

CREATE SCHEMA IF NOT EXISTS pwc245;

CREATE OR REPLACE FUNCTION
pwc245.task1_plpgsql( langs text[], popularity int[] )
RETURNS SETOF text
AS $CODE$

	WITH sorting AS (
		SELECT l
		FROM unnest( langs ) l
		, unnest( popularity ) p
		ORDER BY p DESC
	)
	SELECT distinct( l )
	FROM sorting;

$CODE$
LANGUAGE sql;
