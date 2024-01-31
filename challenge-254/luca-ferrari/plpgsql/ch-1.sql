--
-- Perl Weekly Challenge 254
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-254>
--

CREATE SCHEMA IF NOT EXISTS pwc254;

CREATE OR REPLACE FUNCTION
pwc254.task1_plpgsql( n int )
RETURNS bool
AS $CODE$
BEGIN
	FOR i IN 2 .. sqrt( n )::int LOOP
	    IF pow( i, 3 ) = n THEN
	       RETURN TRUE;
	    END IF;
	END LOOP;

	RETURN FALSE;

END
$CODE$
LANGUAGE plpgsql;
