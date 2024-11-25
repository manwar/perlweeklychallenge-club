--
-- Perl Weekly Challenge 297
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-297>
--

CREATE SCHEMA IF NOT EXISTS pwc297;

CREATE OR REPLACE FUNCTION
pwc297.task2_plpgsql( nums int[] )
RETURNS int
AS $CODE$
	with sorted as (
	     select v::int, row_number() over () as i
	     from unnest( nums ) v
	)
	select f.i - 1 + array_length( nums, 1 ) - l.i
	FROM sorted f, sorted l
	WHERE
	f.v = 1
	and l.v = array_length( nums, 1 )
	;

$CODE$
LANGUAGE sql;
