--
-- Perl Weekly Challenge 272
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-272>
--

CREATE SCHEMA IF NOT EXISTS pwc272;

CREATE OR REPLACE FUNCTION
pwc272.task2_plpgsql( s text )
RETURNS int
AS $CODE$
DECLARE
	score int;
	previous int;
	v int;
BEGIN

	previous := NULL;
	score := 0;
	FOR v IN SELECT ascii( x )::int FROM regexp_split_to_table( s, '' ) x LOOP
	    IF previous IS NOT NULL THEN
	       score := score + abs( previous - v::int );
	    END IF;

	    previous := v::int;

	END LOOP;

	RETURN score;
END
$CODE$
LANGUAGE plpgsql;
