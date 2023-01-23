--
-- Perl Weekly Challenge 200
-- Task 1
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-200/>
--

CREATE SCHEMA IF NOT EXISTS pwc200;

CREATE OR REPLACE FUNCTION
pwc200.task1_plpgsql( list int[] )
RETURNS SETOF int[]
AS $CODE$
DECLARE
BEGIN

	FOR i IN 2 .. array_length( list, 1 ) - 1 LOOP
		IF list[ i + 1 ] - list [ i ] = list[ i ] - list[ i - 1 ] THEN
		   RETURN NEXT array[ list[ i - 1 ], list[ i ], list[ i + 1 ] ];
		END IF;
	END LOOP;

RETURN;

END
$CODE$
LANGUAGE plpgsql;
