--
-- Perl Weekly Challenge 263
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-263>
--

CREATE SCHEMA IF NOT EXISTS pwc263;

CREATE OR REPLACE FUNCTION
pwc263.task1_plpgsql( k int, nums int[] )
RETURNS SETOF int
AS $CODE$

   SELECT x
   FROM (
   	SELECT v, row_number() over ( order by v ) as x
	FROM unnest( nums ) v
	WHERE v = k
	)
$CODE$
LANGUAGE sql;
