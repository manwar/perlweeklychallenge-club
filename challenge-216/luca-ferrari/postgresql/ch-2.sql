--
-- Perl Weekly Challenge 216
-- Task 2
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-216/>
--

CREATE SCHEMA IF NOT EXISTS pwc216;

CREATE OR REPLACE FUNCTION
pwc216.task2_plpgsql( word text, stickers text[] )
RETURNS TABLE ( sticker text, run int, letter text )
AS $CODE$
DECLARE
	cl text;
	current_sticker text;
	m int;
BEGIN
	CREATE TEMPORARY TABLE IF NOT EXISTS letters( l text, c int DEFAULT 1, s text );
	TRUNCATE letters;

	INSERT INTO letters( l, c )
	SELECT ll, count(*)
	FROM regexp_split_to_table( word, '' ) ll
	GROUP BY ll;

	FOUND := true;
	run   := 0;
	WHILE FOUND LOOP
	      	run := run + 1;

		PERFORM count(*)
		FROM letters
		WHERE c > 0;

		IF NOT FOUND THEN
		   RETURN;
		END IF;

		FOR cl IN SELECT l FROM letters WHERE c > 0 LOOP
		    FOREACH current_sticker IN ARRAY stickers LOOP
		    	SELECT count(*)
			INTO m
			FROM regexp_split_to_table( current_sticker, '' ) s
			WHERE s = cl;


			IF m <= 0 THEN
			   CONTINUE;
			END IF;

		     	UPDATE letters
			SET c = c - m
			   , s = s || ', ' || current_sticker;

			sticker := current_sticker;
			letter := cl;

			RETURN NEXT;
			EXIT;
		    END LOOP;
		END LOOP;
	END LOOP;

END
$CODE$
LANGUAGE plpgsql;
