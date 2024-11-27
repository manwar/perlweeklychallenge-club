--
-- Perl Weekly Challenge 290
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-290>
--

CREATE SCHEMA IF NOT EXISTS pwc290;

CREATE OR REPLACE FUNCTION
pwc290.task2_plpgsql( s text )
RETURNS boolean
AS $CODE$
DECLARE
	payload  int;
	checksum int := 0;
	n int;
	last_seen int;
BEGIN
	SELECT right( s, 1 )
	INTO payload;

	FOR n IN SELECT v::int FROM regexp_split_to_table( s, '' ) v LIMIT length( s ) - 1 LOOP
	    IF last_seen IS NOT NULL AND last_seen = n THEN
	       CONTINUE
	    END IF;

	    n := n * 2;
	    IF n > 9 THEN
	       SELECT sum( v::int )
	       INTO n
	       FROM regexp_split_to_table( n::text, '' ) v;
	    END IF;

	    checksum := checksum + n;
	    last_seen = n;
	END LOOP;

	checksum := checksum + payload;
	IF mod( checksum, 10 ) = 0 THEN
	   RETURN true;
	ELSE
	  RETURN false;
	END IF;
END
$CODE$
LANGUAGE plpgsql;
