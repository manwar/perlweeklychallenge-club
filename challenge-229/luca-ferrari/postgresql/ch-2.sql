--
-- Perl Weekly Challenge 229
-- Task 2
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-229/>
--

CREATE SCHEMA IF NOT EXISTS pwc229;

CREATE OR REPLACE FUNCTION
pwc229.task2_plpgsql( aa int[], ab int[], ac int[] )
RETURNS SETOF INT
AS $CODE$
DECLARE
BEGIN
	CREATE TEMPORARY TABLE IF NOT EXISTS bag( v int, c int, a text );
	TRUNCATE TABLE bag;

	INSERT INTO bag( v, c, a )
	SELECT v, count(*), 'a'
	FROM unnest( aa ) v
	GROUP BY 1,3;

	INSERT INTO bag( v, c, a )
	SELECT v, count(*), 'b'
	FROM unnest( ab ) v
	GROUP BY 1,3;

	INSERT INTO bag( v, c, a )
	SELECT v, count(*), 'c'
	FROM unnest( ac ) v
	GROUP BY 1,3;

	RETURN QUERY
	SELECT v
	FROM bag
	WHERE c = 1
	GROUP by v
	HAVING sum( c ) >= 2;
END
$CODE$
LANGUAGE plpgsql;
