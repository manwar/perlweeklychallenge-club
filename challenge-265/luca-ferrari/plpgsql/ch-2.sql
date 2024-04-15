--
-- Perl Weekly Challenge 265
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-265>
--

CREATE SCHEMA IF NOT EXISTS pwc265;

CREATE OR REPLACE FUNCTION
pwc265.task2_plpgsql( needle text, words text[] )
RETURNS text
AS $CODE$
DECLARE
	current text;
	letter text;
	size   int;
	current_count int;
	ok bool;
BEGIN

	CREATE TEMPORARY TABLE IF NOT EXISTS letters( l text, c int );
	TRUNCATE TABLE letters;

	CREATE TEMPORARY TABLE IF NOT EXISTS found_words( w text, c int );
	TRUNCATE TABLE found_words;

	INSERT INTO letters
	SELECT lower( v ), count( v )
	FROM unnest( regexp_split_to_array( needle, '' ) ) v
	WHERE v NOT IN ( '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', ' ' )
	GROUP BY lower( v );


	FOREACH current IN ARRAY words LOOP
		ok := true;

		FOR letter, size IN SELECT l, c FROM letters LOOP
		    SELECT count( v )
		    INTO current_count
		    FROM unnest( regexp_split_to_array( current, '' ) ) v
		    WHERE  v = letter;

		    IF NOT FOUND OR current_count < size THEN
		       ok := false;
		       EXIT;
		    END IF;
		END LOOP;

		IF ok THEN
		   INSERT INTO found_words
		   SELECT current, length( current );
		END IF;
	END LOOP;

	SELECT w
	INTO current
	FROM found_words
	ORDER BY c ASC
	LIMIT 1;

	RETURN current;
END
$CODE$
LANGUAGE plpgsql;
