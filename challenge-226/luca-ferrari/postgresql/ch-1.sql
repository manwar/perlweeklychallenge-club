--
-- Perl Weekly Challenge 226
-- Task 1
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-226/>
--

CREATE SCHEMA IF NOT EXISTS pwc226;

CREATE OR REPLACE FUNCTION
pwc226.task1_plpgsql( word text, indexes int[] )
RETURNS text
AS $CODE$
DECLARE
	i int := 1;
	final_word text := '';
BEGIN
	CREATE TEMPORARY TABLE IF NOT EXISTS  word( letter char, original_index int );
	TRUNCATE word;

	INSERT INTO word( letter, original_index )
	SELECT l, row_number() over ()
	FROM regexp_split_to_table( word, '' ) l;

	FOREACH i IN ARRAY indexes LOOP
		SELECT final_word || l.letter
		INTO final_word
		FROM word l
		WHERE l.original_index = i;
	END LOOP;

	RETURN final_word;
END
$CODE$
LANGUAGE plpgsql;
