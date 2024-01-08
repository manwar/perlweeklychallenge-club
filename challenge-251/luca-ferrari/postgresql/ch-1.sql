--
-- Perl Weekly Challenge 251
-- Task 1
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-251/>
--

CREATE SCHEMA IF NOT EXISTS pwc251;

CREATE OR REPLACE FUNCTION
pwc251.task1_plpgsql( nums int[] )
RETURNS int
AS $CODE$
DECLARE
	s text;
	v int := 0;
BEGIN
	FOR i IN 1 .. array_length( nums, 1 ) - 1 LOOP
	    IF i % 2 = 0 THEN
	       CONTINUE;
	    END IF;

	    v := v + ( nums[ i ]::text || nums[ i + 1 ]::text )::int;
	END LOOP;

	RETURN v;
END
$CODE$
LANGUAGE plpgsql;
