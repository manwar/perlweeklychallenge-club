--
-- Perl Weekly Challenge 348
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-348>
--

CREATE SCHEMA IF NOT EXISTS pwc348;

CREATE OR REPLACE FUNCTION
pwc348.task2_plpgsql( s text, t text )
RETURNS int
AS $CODE$
DECLARE
	operations int := 0;
	src_mins   int := 0;
	dst_mins   int := 0;
	multiplier int := 0;
	v          text;
	x          int;
BEGIN

	multiplier := 60;
	FOR v IN SELECT * FROM regexp_split_to_table( s, '[:]' ) LOOP
	    src_mins := src_mins + v::int * multiplier;
	    multiplier := 1;
	END LOOP;

	multiplier := 60;
	FOR v IN SELECT * FROM regexp_split_to_table( t, '[:]' ) LOOP
	    dst_mins := dst_mins + v::int * multiplier;
	    multiplier := 1;
	END LOOP;

	FOREACH x IN ARRAY array[ 60, 15, 10, 5, 1 ]::int[] LOOP
		WHILE dst_mins - src_mins >= x  LOOP
		      src_mins := src_mins + x;
		      operations := operations + 1;
		END LOOP;
	END LOOP;

	RETURN operations;


END
$CODE$
LANGUAGE plpgsql;
