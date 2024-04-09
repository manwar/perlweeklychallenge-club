--
-- Perl Weekly Challenge 264
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-264>
--

CREATE SCHEMA IF NOT EXISTS pwc264;

CREATE OR REPLACE FUNCTION
pwc264.task1_plpgsql( s text )
RETURNS char
AS $CODE$
DECLARE
	letter char;
BEGIN
	CREATE TEMPORARY TABLE IF NOT EXISTS letters( l char, ok boolean default false );
	TRUNCATE letters;

	INSERT INTO letters
	SELECT v
	FROM regexp_split_to_table( s, '' ) v
	WHERE v ~ '[A-Z]'
	GROUP BY v;

	FOR letter IN SELECT v::char FROM regexp_split_to_table( s, '[a-z]' ) v LOOP
	    UPDATE letters
	    SET ok = true
	    WHERE ok = false
	    AND l = upper( letter );
	END LOOP;

	SELECT l
	INTO letter
	FROM letters
	WHERE ok
	ORDER BY 1 DESC
	LIMIT 1;

	RETURN letter;
END
$CODE$
LANGUAGE plpgsql;
