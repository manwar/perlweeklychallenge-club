--
-- Perl Weekly Challenge 228
-- Task 2
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-228/>
--

CREATE SCHEMA IF NOT EXISTS pwc228;

CREATE OR REPLACE FUNCTION
pwc228.task2_plpgsql( a int[] )
RETURNS int
AS $CODE$
DECLARE
	current_min int;
	current_swap int;
	moves int := 0;
BEGIN
	WHILE array_length( a, 1 ) > 1 LOOP
	      -- find the min value
	      SELECT min( v )
	      INTO current_min
	      FROM unnest( a ) v;



	      -- unshift the first element
	      current_swap := a[ 1 ];
	      a := a[ 2 : array_length( a, 1 ) ];

	      IF current_swap > current_min THEN
	      	 a := array_append( a, current_swap );
	      END IF;

	      moves := moves + 1;

	END LOOP;

	RETURN moves;

END
$CODE$
LANGUAGE plpgsql;
