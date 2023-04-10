--
-- Perl Weekly Challenge 211
-- Task 1
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-211/>
--

CREATE SCHEMA IF NOT EXISTS pwc211;

CREATE OR REPLACE FUNCTION
pwc211.task1_plpgsql( a int[][])
RETURNS bool
AS $CODE$
DECLARE
	current_row  int := 1;
	current_col  int := 1;
	previous_val int := NULL;
BEGIN
	WHILE current_row <= array_length( a, 1 ) LOOP
	      IF current_row > array_length( a, 2 ) THEN
	      	 RETURN false;
              END IF;

	      IF previous_val IS NULL THEN
	      	 previous_val := a[ current_row ][ current_row ];
	      ELSIF previous_val <> a[ current_row ][ current_row ] THEN
	      	   RETURN false;
             END IF;

	     current_row := current_row + 1;
	END LOOP;

	RETURN true;
END
$CODE$
LANGUAGE plpgsql;
