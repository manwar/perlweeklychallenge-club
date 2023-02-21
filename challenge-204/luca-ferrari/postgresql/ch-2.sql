--
-- Perl Weekly Challenge 204
-- Task 2
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-204/>
--

CREATE SCHEMA IF NOT EXISTS pwc204;

CREATE OR REPLACE FUNCTION
pwc204.task2_plpgsql( r int, c int, a int[][] )
RETURNS SETOF int[]
AS $CODE$
DECLARE
	current_row int[];
	index_r int;
	index_c int;
BEGIN
	IF ( r * c ) < ( array_length( a, 1 ) * array_length( a, 2 ) ) THEN
	   RETURN;
	END IF;

	FOR index_r IN 1 .. array_length( a, 1 ) LOOP
	    FOR index_c IN 1 .. array_length( a, 2 ) LOOP
	    	current_row := current_row || a[ index_r ][ index_c ];
		IF array_length( current_row, 1 ) = c THEN
		   RETURN NEXT current_row;
		   current_row := array[]::int[];

		END IF;
	    END LOOP;
	END LOOP;

	RETURN;
END
$CODE$
LANGUAGE plpgsql;
