--
-- Perl Weekly Challenge 216
-- Task 1
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-216/>
--

CREATE SCHEMA IF NOT EXISTS pwc216;

CREATE OR REPLACE FUNCTION
pwc216.task1_plpgsql( rc text, strings text[] )
RETURNS SETOF TEXT
AS $CODE$
DECLARE
	current_word text;
	matches int;
BEGIN
	FOREACH current_word IN ARRAY strings LOOP
	    SELECT count(*)
	    INTO matches
	    FROM regexp_split_to_table( rc, '' ) r
	    , regexp_split_to_table( current_word, '' ) w
	    WHERE r = w;

	    IF matches = length( current_word ) THEN
	       RETURN NEXT current_word;
	    END IF;
	END LOOP;

RETURN;
END
$CODE$
LANGUAGE plpgsql;
