--
-- Perl Weekly Challenge 321
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-321>
--

CREATE SCHEMA IF NOT EXISTS pwc321;

CREATE OR REPLACE FUNCTION
pwc321.task1_plpgsql( numbers int[] )
RETURNS numeric
AS $CODE$
DECLARE
	i int;
	result numeric;
	current int[];
BEGIN
	CREATE TEMPORARY TABLE IF NOT EXISTS averages( v numeric, mx int, mn int );
	TRUNCATE averages;

	FOR i IN 0 .. array_length( numbers, 1 ) / 2 - 1 LOOP

	    INSERT INTO averages( v, mx, mn )
	    SELECT ( min( x::int ) + max( x::int ) ) / 2::numeric
	    	   , max( x )::int
	    	   , min( x )::int

	    FROM unnest( numbers[ 1 + i : array_length( numbers, 1 ) - i ] ) x
	    ;
	END LOOP;

	SELECT min( v )
	INTO result
	FROM averages;

	RETURN result;
END
$CODE$
LANGUAGE plpgsql;
