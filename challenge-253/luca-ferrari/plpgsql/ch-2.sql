--
-- Perl Weekly Challenge 253
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-253>
--

CREATE SCHEMA IF NOT EXISTS pwc253;

CREATE OR REPLACE FUNCTION
pwc253.task2_plpgsql( matrix int[][] )
RETURNS SETOF int
AS $CODE$
DECLARE
	current_row int[];
	c_ones int;
BEGIN
	CREATE TEMPORARY TABLE IF NOT EXISTS ones( r int, c int );
	TRUNCATE ones;

	FOR i IN 1 .. array_length( matrix, 1 ) LOOP
	    c_ones := 0;
	    FOR j IN 1 .. array_length( matrix, 2 ) LOOP
	    	c_ones := c_ones + matrix[ i ][ j ];
	    END LOOP;

    	    INSERT INTO ones
	    SELECT i, c_ones;

	END LOOP;

	RETURN QUERY
	SELECT r
	FROM ones
	ORDER BY c DESC, r ASC;


RETURN;
END
$CODE$
LANGUAGE plpgsql;
