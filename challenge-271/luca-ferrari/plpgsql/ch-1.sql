--
-- Perl Weekly Challenge 271
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-271>
--

CREATE SCHEMA IF NOT EXISTS pwc271;

CREATE OR REPLACE FUNCTION
pwc271.task1_plpgsql( matrix int[][] )
RETURNS int
AS $CODE$
DECLARE

	counting int := 0;
BEGIN

	CREATE TEMPORARY TABLE IF NOT EXISTS ones( r int, v int );
	TRUNCATE ones;

	FOR r IN 1 .. array_length( matrix, 1 ) LOOP
	    counting := 0;

	    FOR c IN 1 .. array_length( matrix, 2 ) LOOP
	    	IF matrix[ r ][ c ] = 1 THEN
		   counting := counting + 1;
		END IF;
	    END LOOP;

	    INSERT INTO ones
	    VALUES( r, counting );
	END LOOP;

	SELECT r
	INTO counting
	FROM ones
	WHERE v = ( SELECT max( v ) FROM ones )
	ORDER BY r asc
	LIMIT 1;


	RETURN counting;

END
$CODE$
LANGUAGE plpgsql;
