--
-- Perl Weekly Challenge 252
-- Task 1
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-252/>
--

CREATE SCHEMA IF NOT EXISTS pwc252;

CREATE OR REPLACE FUNCTION
pwc252.task1_plpgsql( nums int[] )
RETURNS int
AS $CODE$
DECLARE
	sumx int := 0;
BEGIN

	FOR i IN 1 .. array_length( nums, 1 ) LOOP
	    IF mod( array_length( nums, 1 ), i ) <> 0 THEN
	       CONTINUE;
	    END IF;

	    sumx := sumx + pow( nums[ i ], 2 );
	END LOOP;

	RETURN sumx;
END
$CODE$
LANGUAGE plpgsql;
