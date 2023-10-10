--
-- Perl Weekly Challenge 238
-- Task 2
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-238/>
--

CREATE SCHEMA IF NOT EXISTS pwc238;

CREATE OR REPLACE FUNCTION
pwc238.task2_plpgsql( nums int[] )
RETURNS SETOF int
AS $CODE$
DECLARE
	current_value int;
	digit text;
	multiplication int;
	step_counter int;
	value_to_insert int;
BEGIN
	CREATE TEMPORARY TABLE IF NOT EXISTS mul( v int, mul int, steps int DEFAULT 0 );
	TRUNCATE mul;

	FOREACH current_value IN ARRAY nums LOOP
		IF current_value < 9 THEN
		   INSERT INTO mul( v, mul )
		   VALUES( current_value, current_value );
		   CONTINUE;
		END IF;

		-- if here the number is at least two digits long
		step_counter := 0;
		value_to_insert := current_value;
		WHILE current_value > 9 LOOP
		      multiplication := 1;
		      step_counter := step_counter + 1;

		      FOREACH digit IN ARRAY regexp_split_to_array( current_value::text, '' ) LOOP
		      	      multiplication := multiplication * digit::int;
		      END LOOP;

		      current_value := multiplication;
		END LOOP;

		INSERT INTO mul( v, mul, steps )
		VALUES( value_to_insert, multiplication, step_counter );

	END LOOP;


	RETURN QUERY SELECT v
	       	     FROM mul
		     ORDER BY steps ASC, v ASC;
END

$CODE$
LANGUAGE plpgsql;
