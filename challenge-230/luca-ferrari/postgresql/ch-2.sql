--
-- Perl Weekly Challenge 230
-- Task 2
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-230/>
--

CREATE SCHEMA IF NOT EXISTS pwc230;

CREATE OR REPLACE FUNCTION
pwc230.task2_plpgsql( pref text, words text[] )
RETURNS INT
AS $CODE$
DECLARE
	current_word text;
	counter int := 0;
BEGIN
	FOREACH current_word IN ARRAY words LOOP
		IF regexp_match( current_word, '^' || pref ) IS NOT NULL THEN
		   counter := counter + 1;
		END IF;
	END LOOP;

	RETURN counter;
END
$CODE$
LANGUAGE plpgsql;
