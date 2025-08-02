--
-- Perl Weekly Challenge 269
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-269>
--

CREATE SCHEMA IF NOT EXISTS pwc269;

CREATE OR REPLACE FUNCTION
pwc269.task2_plpgsql( nums int[] )
RETURNS SETOF int
AS $CODE$
DECLARE
	array1 int[];
	array2 int[];
	i int;
BEGIN

	i := 1;
	array1 := array_append( array1, nums[ 1 ] );
	array2 := array_append( array2, nums[ 2 ] );
	i := i + 2;

	WHILE i < array_length( nums, 1 ) LOOP
	      IF array1[ i - 2 ] > array2[ i - 1 ] THEN
	      	 array1 := array_append( array1, nums[ i ] );
	      ELSE
	        array2 := array_append( array2, nums[ i ] );
	      END IF;

	      I := I + 2;
	END LOOP;

	RETURN QUERY SELECT v
	       	     FROM unnest( array1 ) v
		     UNION
		     SELECT v
		     FROM unnest( array2 ) v;
END
$CODE$
LANGUAGE plpgsql;
