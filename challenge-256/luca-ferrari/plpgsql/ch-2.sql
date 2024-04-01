--
-- Perl Weekly Challenge 256
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-256>
--

CREATE SCHEMA IF NOT EXISTS pwc256;

CREATE OR REPLACE FUNCTION
pwc256.task2_plpgsql( lw text, rw text )
RETURNS text
AS $CODE$
DECLARE
	max_index int;
	output text := '';
	next_char char;
BEGIN
	CREATE TEMPORARY TABLE IF NOT EXISTS words( l char, r char, o int );
	TRUNCATE words;

	INSERT INTO words( l, o )
	SELECT v, row_number() over ()
	FROM regexp_split_to_table( lw, '' ) v;

	INSERT INTO words( r, o )
	SELECT v, row_number() over ()
	FROM regexp_split_to_table( rw, '' ) v;

	SELECT max( o )
	INTO max_index
	FROM words;

	FOR i IN 1 .. max_index LOOP
	    SELECT l
	    INTO next_char
	    FROM words
	    WHERE o = i
	    AND l IS NOT NULL;

	    IF FOUND AND next_char IS NOT NULL THEN
	       output := output || next_char;
	    END IF;

	    SELECT r
	    INTO next_char
	    FROM words
	    WHERE o = i
	    AND r IS NOT NULL;

	    IF FOUND AND next_char IS NOT NULL THEN
	       output := output || next_char;
	    END IF;
	END LOOP;

	RETURN output;

END
$CODE$
LANGUAGE plpgsql;
