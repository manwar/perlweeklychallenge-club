--
-- Perl Weekly Challenge 258
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-258>
--

CREATE SCHEMA IF NOT EXISTS pwc258;

CREATE OR REPLACE FUNCTION
pwc258.task1_plpgsql( nums int[] )
RETURNS int
AS $CODE$
   WITH q_nums AS (
   	SELECT v, array_length( regexp_split_to_array( v::text, '' ), 1 ) as c
	FROM unnest( nums ) v
	)
	SELECT count( * )
	FROM q_nums
	WHERE c % 2 = 0;

$CODE$
LANGUAGE sql;
