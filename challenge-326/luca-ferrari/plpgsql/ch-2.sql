--
-- Perl Weekly Challenge 326
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-326>
--

CREATE SCHEMA IF NOT EXISTS pwc326;

CREATE OR REPLACE FUNCTION
pwc326.task2_plpgsql( nums int[] )
RETURNS SETOF int
AS $CODE$
DECLARE
	i int;
	base int;
	times int;
BEGIN

	FOR i IN 1 .. array_length( nums, 1 ) - 1 LOOP
	    IF mod( i, 2 ) = 0 THEN
	       CONTINUE;
	    END IF;

	    base  := nums[ i ];
	    times := nums[ i + 1 ];


	    FOR j in 1 .. times LOOP
	    	RETURN NEXT base;
            END LOOP;
	END LOOP;

RETURN;
END
$CODE$
LANGUAGE plpgsql;
