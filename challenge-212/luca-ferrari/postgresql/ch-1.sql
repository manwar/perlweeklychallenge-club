--
-- Perl Weekly Challenge 212
-- Task 1
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-212/>
--

CREATE SCHEMA IF NOT EXISTS pwc212;

CREATE TABLE IF NOT EXISTS pwc212.alphabet
(
  l char
  , n int
  , PRIMARY KEY( l )
);

TRUNCATE pwc212.alphabet;
INSERT INTO pwc212.alphabet
SELECT l, row_number() over ()
FROM regexp_split_to_table( 'abcdefghijklmnopqrstuvwxyz', '' ) l;



CREATE OR REPLACE FUNCTION
pwc212.task1_plpgsql( s text, jumps int[] )
RETURNS text
AS $CODE$
DECLARE
	letter text;
	word text;
	idx int;
	off int := 0;
	alphabet_size int;
BEGIN

	SELECT count(*)
	INTO alphabet_size
	FROM pwc212.alphabet;

	word := '';

	FOR letter IN SELECT * FROM regexp_split_to_table( s, '' )  LOOP
	    SELECT n
	    INTO  idx
	    FROM pwc212.alphabet
	    WHERE l = letter;


	    SELECT mod( i + idx, alphabet_size )
	    INTO idx
	    FROM unnest( jumps ) i
	    LIMIT 1 	    OFFSET off;
	    off := off + 1;

	    SELECT l
	    INTO letter
	    FROM pwc212.alphabet
	    WHERE n = idx;

	    word := word || letter;

	END LOOP;

	RETURN word;
END
$CODE$
LANGUAGE plpgsql;
