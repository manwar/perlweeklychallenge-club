--
-- Perl Weekly Challenge 254
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-254>
--

CREATE SCHEMA IF NOT EXISTS pwc254;

CREATE OR REPLACE FUNCTION
pwc254.task2_plpgsql( word text )
RETURNS text
AS $CODE$
DECLARE
	output_string text := '';
	current_vowel char;
	current_index int;
	remaining_vowels int;
	letter char;
BEGIN
	CREATE TEMPORARY TABLE IF NOT EXISTS vowels( v char, i serial );
	TRUNCATE vowels;

	INSERT INTO vowels( v )
	SELECT v
	FROM regexp_split_to_table( lower( word ), '' ) v
	WHERE v IN ( 'a', 'e', 'i', 'o', 'u' );

	FOR letter IN SELECT v FROM regexp_split_to_table( lower( word ), '' ) v LOOP

	    SELECT count( * )
	    FROM vowels
	    INTO remaining_vowels;

	    IF letter NOT IN ('a', 'e', 'i', 'o', 'u' ) OR remaining_vowels = 0 THEN
	       output_string := output_string || letter;
	    ELSE
		SELECT v, i
		INTO current_vowel, current_index
		FROM vowels
		ORDER BY i DESC;

		output_string := output_string || current_vowel;
		DELETE FROM vowels WHERE i = current_index;
	    END IF;
	END LOOP;

	RETURN output_string;
END
$CODE$
LANGUAGE plpgsql;
