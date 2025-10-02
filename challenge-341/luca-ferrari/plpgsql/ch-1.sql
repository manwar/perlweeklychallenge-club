--
-- Perl Weekly Challenge 341
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-341>
--

CREATE SCHEMA IF NOT EXISTS pwc341;

CREATE OR REPLACE FUNCTION
pwc341.task1_plpgsql( sentence text, keys text[] )
RETURNS SETOF text
AS $CODE$
DECLARE
	current_word text;
	ko int;
	k text;
BEGIN
	FOR current_word IN SELECT w FROM regexp_split_to_table( sentence, '\s+' ) w LOOP
	    ko := 0;

	    FOREACH k IN ARRAY keys LOOP
	    	IF current_word ~ k THEN
		   ko := ko + 1;
		END IF;
	    END LOOP;

	    IF ko = 0 THEN
	       RETURN NEXT current_word;
	    END IF;

	END LOOP;

RETURN;
END
$CODE$
LANGUAGE plpgsql;
