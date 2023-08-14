--
-- Perl Weekly Challenge 229
-- Task 1
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-229/>
--

CREATE SCHEMA IF NOT EXISTS pwc229;

CREATE OR REPLACE FUNCTION
pwc229.task1_plpgsql( words text[] )
RETURNS int
AS $CODE$
DECLARE
	current_word text;
	sorted_word text;
	deleted int := 0;
BEGIN

	FOREACH current_word IN ARRAY words LOOP
		WITH letters( l ) AS (
		     SELECT regexp_split_to_table( current_word, '' )::text
		     ORDER BY 1
		)
		SELECT string_agg( l, '' )
		INTO sorted_word
		FROM letters;

		IF sorted_word <> current_word THEN
		   deleted := deleted + 1;
		END IF;
	END LOOP;

	RETURN deleted;
END

$CODE$
LANGUAGE plpgsql;
