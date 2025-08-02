--
-- Perl Weekly Challenge 267
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-267>
--

CREATE SCHEMA IF NOT EXISTS pwc267;

CREATE OR REPLACE FUNCTION
pwc267.task2_plpgsql( s text, w int[] )
RETURNS TABLE( line int, width int )
AS $CODE$
DECLARE
	l text;
	n_value int;
BEGIN
	CREATE TEMPORARY TABLE IF NOT EXISTS pixels( letter char, pixels int );
	TRUNCATE pixels;

	FOR i IN 1 .. array_length( w, 1 ) LOOP
	    INSERT INTO pixels
	    VALUES( chr( 97 + i - 1 ), w[ i ] );
	END LOOP;

	width := 0;
	line  := 1;

	FOR l IN SELECT v FROM regexp_split_to_table( s, '' ) v LOOP
		SELECT pixels
		INTO n_value
		FROM pixels
		WHERE letter = l;

		IF n_value + width > 100 THEN
		   width := 0;
		   line  := line + 1;
		END IF;

		width := width + n_value;
	END LOOP;


	RETURN NEXT;
	RETURN;
END


$CODE$
LANGUAGE plpgsql;
