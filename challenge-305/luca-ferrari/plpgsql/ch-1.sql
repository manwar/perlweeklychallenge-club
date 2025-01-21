--
-- Perl Weekly Challenge 306
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-306>
--

CREATE SCHEMA IF NOT EXISTS pwc306;


CREATE OR REPLACE FUNCTION is_prime( n int )
RETURNS bool
AS $CODE$
DECLARE
	i int;
BEGIN
	IF n <= 1 THEN
	   RETURN false;
	END IF;

	FOR i IN 2 .. n - 1 LOOP
	    IF mod( n, i ) = 0 THEN
	       RETURN false;
	    END IF;
	END LOOP;

	RETURN true;
END
$CODE$
LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION
pwc306.task1_plpgsql( bits bit[] )
RETURNS SETOF bool
AS $CODE$
DECLARE
	i int;
	s text;
BEGIN

	FOR i in 1 .. array_length( bits, 1 ) LOOP
	    SELECT '0b' || string_agg( v::text, '' )
	    INTO s
	    FROM unnest( bits[ 0 : i ] ) v;

	    IF is_prime( s::int ) THEN
	       RETURN NEXT true;
	    ELSE
	      RETURN NEXT false;
	    END IF;
	END LOOP;

	RETURN;
END
$CODE$
LANGUAGE plpgsql;
