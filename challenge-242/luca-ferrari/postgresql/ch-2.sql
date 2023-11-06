--
-- Perl Weekly Challenge 242
-- Task 2
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-242/>
--

CREATE SCHEMA IF NOT EXISTS pwc242;

/*
estdb=> select pwc242.task2_plpgsql( array[1,0,0,0,0,0,0,1,1]::int[], 3 );
 task2_plpgsql
---------------
 {1,1,0}
 {1,1,1}
 {0,0,1}
(3 rows)
*/
CREATE OR REPLACE FUNCTION
pwc242.task2_plpgsql( matrix int[], l int )
RETURNS SETOF int[]
AS $CODE$
DECLARE
	current_row text;
	current int;
	index int;
	to_return int;
	result int[];
BEGIN
	index := 1;
	current_row := '';

	FOREACH current IN ARRAY matrix LOOP
		current_row := current_row || current::text;
		IF index = l THEN
		   -- the row is now complete, flip and split
		   result := array[]::int[];
		   FOREACH to_return IN ARRAY regexp_split_to_array( reverse( current_row ), '' ) LOOP
		   	   IF to_return = 1 THEN
			      result := array_append( result, 0 );
			   ELSE
			      result := array_append( result, 1 );
			   END IF;
		   END LOOP;

		   RETURN NEXT result;

		   -- start over
		   current_row := '';
		   index := 1;
		ELSE
    		   index := index + 1;
		END IF;
	END LOOP;

	RETURN;
END
$CODE$
LANGUAGE plpgsql;
