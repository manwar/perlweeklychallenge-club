--
-- Perl Weekly Challenge 348
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-348>
--

CREATE SCHEMA IF NOT EXISTS pwc348;

CREATE OR REPLACE FUNCTION
pwc348.task1_plpgsql( s text )
RETURNS boolean
AS $CODE$
DECLARE
	lc int;
	rc int;
	sz int;
BEGIN
	if mod( length( s ), 2 ) <> 0 then
	   return false;
	else
	  sz := length( s ) / 2;
	end if;

	SELECT count( t.* )
	INTO lc
	FROM ( SELECT regexp_matches( lower( left( s, sz ) ), '[aeiou]' ) )  t;

	SELECT count( t.* )
	INTO rc
	FROM ( SELECT regexp_matches( lower( right( s, sz ) ), '[aeiou]' ) )  t;


	IF lc = rc THEN
	   RETURN true;
        ELSE
	  RETURN false;
	END IF;
END
$CODE$
LANGUAGE plpgsql;
