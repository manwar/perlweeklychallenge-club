--
-- Perl Weekly Challenge 248
-- Task 2
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-248/>
--

CREATE SCHEMA IF NOT EXISTS pwc248;

CREATE OR REPLACE FUNCTION
pwc248.task2_plpgsql( matrix int[] )
RETURNS SETOF int[]
AS $CODE$
DECLARE
	current_row int[];
BEGIN

	FOR r IN 1 .. array_length( matrix, 1 ) - 1 LOOP

	    current_row = array[ array_length( matrix, 1 ) ];

	    FOR c IN 1 .. array_length( matrix, 2 ) - 1 LOOP
	    	current_row[ c ] = matrix[ r ][ c ] + matrix[ r ][ c + 1 ] + matrix[ r + 1 ][ c ] + matrix[ r + 1 ][ c + 1 ];
	    END LOOP;

	    RETURN NEXT current_row;
	END LOOP;

RETURN;
END
$CODE$
LANGUAGE plpgsql;
