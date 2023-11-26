--
-- Perl Weekly Challenge 239
-- Task 2
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-239/>
--

CREATE SCHEMA IF NOT EXISTS pwc239;

CREATE OR REPLACE FUNCTION
pwc239.task2_plpgsql( allowed text, words text[] )
RETURNS SETOF text
AS $CODE$
DECLARE
	current_word text;
	current_char text;
	ok boolean;
BEGIN
	FOREACH current_word IN ARRAY words LOOP
		ok := true;

		FOREACH current_char IN ARRAY regexp_split_to_array( current_word, '' ) LOOP
			IF NOT regexp_like( allowed, current_char ) THEN
			   ok := false;
			   EXIT;
		       END IF;
		END LOOP; -- foreach

		IF ok THEN
		   RETURN NEXT current_word;
		END IF;
	END LOOP;  -- foreach external

RETURN;
END
$CODE$
LANGUAGE plpgsql;
