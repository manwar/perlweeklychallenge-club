--
-- Perl Weekly Challenge 241
-- Task 2
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-241/>
--

CREATE SCHEMA IF NOT EXISTS pwc241;


CREATE OR REPLACE FUNCTION
pwc241.primes( n int )
RETURNS SETOF int
AS $CODE$
BEGIN
	FOR i IN 2 .. n LOOP
	    WHILE ( n % i ) = 0 LOOP
	    	  RETURN NEXT i;
		  n := n / i;
	    END LOOP;


	    IF n = 1 THEN
	       RETURN;
	    END IF;
	END LOOP;

RETURN;
END
$CODE$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION
pwc241.task2_plpgsql( nums int[] )
RETURNS SETOF int
AS $CODE$
DECLARE
	v int;
BEGIN
	CREATE TEMPORARY TABLE IF NOT EXISTS sorted( n int, p int DEFAULT 0 );
	TRUNCATE sorted;

	FOREACH v IN ARRAY nums LOOP
		INSERT INTO sorted( n, p )
		SELECT v, pp
		FROM pwc241.primes( v ) pp;
	END LOOP;

	RETURN QUERY
	       WITH q( n ) AS ( SELECT n FROM sorted ORDER BY p asc )
	       SELECT distinct n
	       FROM Q qq;


END
$CODE$
LANGUAGE plpgsql;
