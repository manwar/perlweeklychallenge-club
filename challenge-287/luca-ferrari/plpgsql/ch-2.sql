--
-- Perl Weekly Challenge 287
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-287>
--

CREATE SCHEMA IF NOT EXISTS pwc287;

CREATE OR REPLACE FUNCTION
pwc287.task2_plpgsql( n text )
RETURNS bool
AS $CODE$
DECLARE
	counter int := 0;
BEGIN

	SELECT count( x )
	INTO counter
	FROM regexp_matches( n, '^[+-]?\d+(.\d+)?(E[+-]?\d+)?$' ) x;

	IF counter > 0 THEN
	   RETURN true;
        ELSE
	  RETURN false;
       END IF;
END
$CODE$
LANGUAGE plpgsql;
