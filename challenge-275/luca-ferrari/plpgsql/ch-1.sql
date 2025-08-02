--
-- Perl Weekly Challenge 275
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-275>
--

CREATE SCHEMA IF NOT EXISTS pwc275;

CREATE OR REPLACE FUNCTION
pwc275.task1_plpgsql( s text, k text[] )
RETURNS int
AS $CODE$
DECLARE
	ok boolean;
	current_k text;
	current text;
	word_counter int := 0;
BEGIN

	FOR current IN SELECT word FROM regexp_split_to_table( s, '\s+' ) word LOOP
    	    ok := true;

	    FOREACH current_k IN ARRAY k LOOP
	    	    IF current ~ current_k THEN
		       ok := false;
		    END IF;
	    END LOOP;

	    IF ok THEN
	       word_counter := word_counter + 1;
	    END IF;
	END LOOP;

	RETURN word_counter;
END
$CODE$
LANGUAGE plpgsql;
