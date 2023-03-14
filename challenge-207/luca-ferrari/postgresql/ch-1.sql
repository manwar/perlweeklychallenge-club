--
-- Perl Weekly Challenge 207
-- Task 1
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-207/>
--

CREATE SCHEMA IF NOT EXISTS pwc207;

CREATE OR REPLACE FUNCTION
pwc207.task1_plpgsql( w text[] )
RETURNS SETOF text
AS $CODE$
DECLARE
	current_word text;
	current_row  text;
	letters_found int;
BEGIN

	CREATE TEMPORARY TABLE IF NOT EXISTS keyboard( k text );
	TRUNCATE keyboard;
	INSERT INTO keyboard( k )
	VALUES( 'qwertyuiop' ), ( 'asdfghjkl' ), ( 'zxcvbnm' );

	FOREACH current_word IN ARRAY w LOOP
		FOR current_row IN SELECT k FROM keyboard LOOP
			letters_found := 0;

			SELECT count(*)
			INTO   letters_found
			FROM   regexp_split_to_table( current_word, '' ) ww
			JOIN   regexp_split_to_table( current_row, '' ) kk
			ON     ww = kk;

			IF letters_found = length( current_word ) THEN
			   RETURN NEXT current_word;
			   EXIT;
			END IF;
		END LOOP;
	END LOOP;

RETURN;
END
$CODE$
LANGUAGE plpgsql;
