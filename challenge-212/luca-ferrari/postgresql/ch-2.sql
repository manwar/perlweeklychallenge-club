--
-- Perl Weekly Challenge 212
-- Task 2
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-212/>
--

CREATE SCHEMA IF NOT EXISTS pwc212;

CREATE OR REPLACE FUNCTION
pwc212.task2_plpgsql( a int[], s int)
RETURNS SETOF int[]
AS $CODE$
DECLARE
	current int[];
	done    int := 0;
	next_value int;
BEGIN

	-- check if the array can be divided into batches
	IF mod( array_length( a, 1 ), s ) <> 0 THEN
	   RETURN;
	END IF;

	CREATE TEMPORARY TABLE IF NOT EXISTS bag( v int, c int default 1 );
	TRUNCATE TABLE bag;
	INSERT INTO bag
	SELECT v, count(*)
	FROM unnest( a ) v
	GROUP BY v;


	WHILE done < ( array_length( a, 1 ) / s ) LOOP
	      current = array[]::int[];

	      WHILE array_length( current, 1 ) IS NULL OR array_length( current, 1 ) < s LOOP
	      	    SELECT min( v )
		    INTO next_value
		    FROM   bag
		    WHERE  c > 0
		    AND   v NOT IN ( SELECT * FROM unnest( current ) );

		    UPDATE bag
		    SET c = c - 1
		    WHERE v = next_value;

		    current := array_append( current, next_value );
	      END LOOP;

	      done := done + 1;
	      RETURN NEXT current;
	END LOOP;

RETURN;
END
$CODE$
LANGUAGE plpgsql;
