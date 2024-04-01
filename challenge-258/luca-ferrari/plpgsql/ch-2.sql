--
-- Perl Weekly Challenge 258
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-258>
--

CREATE SCHEMA IF NOT EXISTS pwc258;

CREATE OR REPLACE FUNCTION
pwc258.task2_plpgsql( k int, nums int[] )
RETURNS int
AS $CODE$
DECLARE
	v_sum int := 0;
	count_of_ones int := 0;
BEGIN
	FOR i IN 1 .. array_length( nums, 1 ) LOOP
		SELECT sum( v::int )
		INTO count_of_ones
		FROM regexp_split_to_table( i::bit( 8 )::text, '' ) v;

		IF count_of_ones <> k THEN
		   continue;
		END IF;

		v_sum := v_sum + nums[ i ];
	END LOOP;

	RETURN v_sum;
END
$CODE$
LANGUAGE plpgsql;
