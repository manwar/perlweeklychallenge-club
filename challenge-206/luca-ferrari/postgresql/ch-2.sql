--
-- Perl Weekly Challenge 206
-- Task 1
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-206/>
--

CREATE SCHEMA IF NOT EXISTS pwc206;

CREATE OR REPLACE FUNCTION
pwc206.task2_plpgsql( l int[] )
RETURNS int
AS $CODE$
DECLARE
   res int;
BEGIN
	WITH data AS (
    	    SELECT v, row_number() OVER ( ORDER BY v ) r
	    FROM unnest( l ) v
	)
	SELECT sum( v )
	INTO res
	FROM data
	WHERE r % 2 <> 0
	;

	RETURN res;
END
$CODE$
LANGUAGE plpgsql;
