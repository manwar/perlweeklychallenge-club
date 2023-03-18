--
-- Perl Weekly Challenge 208
-- Task 2
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-208/>
--

CREATE SCHEMA IF NOT EXISTS pwc208;

CREATE OR REPLACE FUNCTION
pwc208.task2_plpgsql( l int[] )
RETURNS TABLE( v int, d text )
AS $CODE$
	WITH res AS (
	     SELECT v, count( vv ) AS c
	     FROM generate_series( l[1], l[ array_length( l, 1 ) ] ) v
	     LEFT JOIN unnest( l ) vv ON vv = v
	     GROUP BY v
	)
	SELECT v, 'Duplicated value ' || v
	FROM res
	WHERE c > 1
	UNION
	SELECT v, 'Missing value ' || v
	FROM res
	WHERE c = 0;

$CODE$
LANGUAGE sql;
