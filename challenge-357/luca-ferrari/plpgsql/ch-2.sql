--
-- Perl Weekly Challenge 357
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-357>
--

CREATE SCHEMA IF NOT EXISTS pwc357;

CREATE OR REPLACE FUNCTION
pwc357.task2_plpgsql( num int )
RETURNS SETOF text
AS $CODE$
DECLARE
	r record;
BEGIN

	CREATE TEMPORARY TABLE IF NOT EXISTS fractions( n int, d int, f text, v numeric );
	TRUNCATE TABLE fractions;

	FOR r IN SELECT n, d
	       	    FROM generate_series( 1, num ) n,
		         generate_series( 1, num ) d LOOP



		INSERT INTO fractions( n, d, f, v )
		VALUES( r.n, r.d, r.n || '/' || r.d, r.n::numeric / r.d::numeric );

	END LOOP;

	RETURN QUERY SELECT f
	            FROM fractions f1
		    WHERE f1.n = ( select min( f2.n )
		                   from fractions f2
				   where f2.v = f1.v
				 )
	       	    GROUP BY v, f
	       	    ORDER BY v asc;

END
$CODE$
LANGUAGE plpgsql;
