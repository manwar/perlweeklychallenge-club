--
-- Perl Weekly Challenge 202
-- Task 2
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-202/>
--

CREATE SCHEMA IF NOT EXISTS pwc202;

CREATE OR REPLACE FUNCTION
pwc202.task2_plpgsql( l int[] )
RETURNS SETOF int[]
AS $CODE$
DECLARE
	cur int;
	lft int[];
	rgt int[];
	idx int;
	iter int;
	prev int;
BEGIN

	CREATE TEMPORARY TABLE IF NOT EXISTS pwc202
	( lft int[], rgt int[], dim int DEFAULT 0 );
	TRUNCATE pwc202;


	FOR idx IN 1 .. array_length( l, 1 ) - 1 LOOP
		cur := l[ idx ];
		IF l[ idx + 1 ] > cur THEN
		   CONTINUE;
		END IF;

		lft := NULL;
		lft := array_append( lft, cur );
		FOR iter IN idx + 1 .. array_length( l, 1 ) - 1 LOOP
		    prev := lft[ array_length( lft, 1 ) ];
		    IF l[ iter ] <= prev THEN
		       lft := array_append( lft, l[ iter ] );
		    END IF;
		    EXIT WHEN l[ iter ] > prev;
		END LOOP;

		rgt := NULL;
		IF array_length( lft, 1 ) + idx <= array_length( l, 1 ) THEN
		   prev := l[ idx + array_length( lft, 1 ) ];
		   rgt := array_append( rgt, prev );
		   FOR iter IN array_length( lft, 1 ) + idx + 1 .. array_length( l, 1 )  LOOP
		      prev := rgt[ array_length( rgt, 1 ) ];
		      IF l[ iter ] >= prev THEN
		       rgt := array_append( rgt, l[ iter ] );
		      END IF;
		      EXIT WHEN l[ iter ] < prev;
		   END LOOP;
		END IF;

		INSERT INTO pwc202
		VALUES( lft, rgt, array_length( lft, 1 ) + array_length( rgt, 1 ) );



	END LOOP;

       RETURN QUERY SELECT array_cat( p.lft, p.rgt )
       FROM pwc202 p
       ORDER BY dim DESC
       LIMIT 1;
END
$CODE$
LANGUAGE plpgsql;
