--
-- Perl Weekly Challenge 263
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-263>
--

CREATE SCHEMA IF NOT EXISTS pwc263;

CREATE OR REPLACE FUNCTION
pwc263.task2_plpgsql( i int[], j int[] )
RETURNS TABLE( item int, qty int )
AS $CODE$
DECLARE

BEGIN

	CREATE TEMPORARY TABLE IF NOT EXISTS q( item int, qty int );
	TRUNCATE TABLE q;

	FOR x IN 1 .. array_length( i, 1 ) LOOP
	    IF mod( x, 2 ) = 0 THEN
	       CONTINUE;
	    END IF;
	    INSERT INTO q( item, qty )
	    VALUES ( i[ x ], i[ x + 1 ] );

	END LOOP;

	FOR x IN 1 .. array_length( j, 1 ) LOOP
	     IF mod( x, 2 ) = 0 THEN
	       CONTINUE;
	    END IF;
	    INSERT INTO q( item, qty )
	    VALUES ( j[ x ], j[ x + 1 ] );

	END LOOP;

	RETURN QUERY
	SELECT q.item, sum( q.qty )::int
	FROM q
	GROUP BY q.item;

END
$CODE$
LANGUAGE plpgsql;
