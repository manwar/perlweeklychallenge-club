--
-- Perl Weekly Challenge 265
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-265>
--

CREATE SCHEMA IF NOT EXISTS pwc265;

CREATE OR REPLACE FUNCTION
pwc265.task1_plpgsql( nums int[] )
RETURNS int
AS $CODE$

	SELECT v
	FROM unnest( nums ) v
	GROUP BY v
	HAVING count( v ) / array_length( nums, 1 ) >= ( 33 / 100 )
	ORDER BY v ASC
	LIMIT 1;

$CODE$
LANGUAGE sql;
