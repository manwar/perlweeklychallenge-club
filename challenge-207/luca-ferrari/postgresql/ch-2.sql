--
-- Perl Weekly Challenge 207
-- Task 2
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-207/>
--

CREATE SCHEMA IF NOT EXISTS pwc207;

CREATE OR REPLACE FUNCTION
pwc207.task2_plpgsql( citations int[] )
RETURNS SETOF int
AS $CODE$
DECLARE
BEGIN
	RETURN QUERY WITH d AS (
	   SELECT c, row_number() OVER ( ORDER BY c desc ) r
	   FROM   unnest( citations ) c
	)
	SELECT MIN( r )
	FROM   d
	WHERE  r >= c
	;
END
$CODE$
LANGUAGE plpgsql;
