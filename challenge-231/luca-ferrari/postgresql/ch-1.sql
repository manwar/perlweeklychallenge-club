--
-- Perl Weekly Challenge 231
-- Task 1
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-231/>
--

CREATE SCHEMA IF NOT EXISTS pwc231;

CREATE OR REPLACE FUNCTION
pwc231.task1_plpgsql( nums int[] )
RETURNS SETOF int
AS $CODE$
	SELECT
	v
	FROM unnest( nums ) v
	WHERE v <> ( SELECT max( vv ) FROM unnest( nums ) vv )
	AND   v <> ( SELECT min( vv ) FROM unnest( nums ) vv )
	;
$CODE$
LANGUAGE sql;
