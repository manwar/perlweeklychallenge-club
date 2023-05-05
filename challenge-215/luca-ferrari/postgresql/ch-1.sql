--
-- Perl Weekly Challenge 215
-- Task 1
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-215/>
--

CREATE SCHEMA IF NOT EXISTS pwc215;

CREATE OR REPLACE FUNCTION
pwc215.task1_plpgsql( words text[] )
RETURNS SETOF text
AS $CODE$
DECLARE
	current_word text;
	sorted_word  text;
	current_letter text;
BEGIN
	FOREACH current_word IN ARRAY words LOOP
	        /*
		sorted_word := '';
		FOR current_letter IN SELECT l FROM regexp_split_to_table( current_word, '' ) l ORDER BY 1 LOOP
		    sorted_word := sorted_word || current_letter;
   	        END LOOP;
                */

		SELECT string_agg( c, '' )
		INTO sorted_word
		FROM ( SELECT c
		       FROM regexp_split_to_table( current_word, '' ) c
		       ORDER BY 1
		     ) c;

		IF sorted_word = current_word THEN
		   RETURN NEXT current_word;
		END IF;
	END LOOP;

RETURN;
END
$CODE$
LANGUAGE plpgsql;
