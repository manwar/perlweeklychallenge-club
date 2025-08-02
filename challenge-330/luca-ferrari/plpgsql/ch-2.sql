--
-- Perl Weekly Challenge 330
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-330>
--

CREATE SCHEMA IF NOT EXISTS pwc330;

CREATE OR REPLACE FUNCTION
pwc330.task2_plpgsql( s text )
RETURNS SETOF text
AS $CODE$
DECLARE
	current text;
BEGIN
	FOR current IN SELECT v FROM regexp_split_to_table( s, ' ' ) v LOOP
	    IF length( current ) >= 3 THEN
	       current := upper( current );
	    ELSE
	       current := lower( current );
	    END IF;

	    RETURN NEXT current;
	END LOOP;

RETURN;

END
$CODE$
LANGUAGE plpgsql;
