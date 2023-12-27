--
-- Perl Weekly Challenge 249
-- Task 1
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-249/>
--

CREATE SCHEMA IF NOT EXISTS pwc249;

CREATE OR REPLACE FUNCTION
pwc249.task1_plpgsql( n int[] )
RETURNS SETOF int[]
AS $CODE$
DECLARE
	r record;
BEGIN
	CREATE TEMPORARY TABLE IF NOT EXISTS classification( v int, c int DEFAULT 1);
	TRUNCATE classification;


	WITH nums AS ( SELECT v::int
	    	      FROM unnest( n ) v )
	, counting AS ( SELECT v, count( v ) as c
	  	        FROM nums
			GROUP BY v )
	INSERT INTO classification( v, c )
	SELECT v, c
	FROM counting;

	FOR r IN SELECT * FROM classification WHERE c >= 2 ORDER BY v LOOP
	    WHILE r.c >= 1 LOOP
	    	  RETURN NEXT array[ r.v, r.v ]::int[];
		  r.c := r.c - 2;
	    END LOOP;
	END LOOP;

RETURN;
END
$CODE$
LANGUAGE plpgsql;
