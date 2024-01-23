--
-- Perl Weekly Challenge 253
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-253>
--

CREATE SCHEMA IF NOT EXISTS pwc253;

CREATE OR REPLACE FUNCTION
pwc253.task1_plpgsql( s char, words text[] )
RETURNS SETOF text
AS $CODE$
DECLARE
	current_word text;
BEGIN
	FOREACH current_word IN ARRAY words LOOP
		RETURN QUERY
		SELECT regexp_split_to_table( current_word, '[' || s || ']' );
	END LOOP;

RETURN;
END
$CODE$
LANGUAGE plpgsql;
