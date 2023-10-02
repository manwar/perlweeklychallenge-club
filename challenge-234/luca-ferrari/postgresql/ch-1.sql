--
-- Perl Weekly Challenge 234
-- Task 1
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-234/>
--

CREATE SCHEMA IF NOT EXISTS pwc234;

CREATE OR REPLACE FUNCTION
pwc234.task1_plpgsql( words text[] )
RETURNS SETOF char
AS $CODE$
DECLARE
	w text;
BEGIN
	CREATE TEMPORARY TABLE IF NOT EXISTS chars( c char, word text );
	TRUNCATE chars;

	FOREACH w IN ARRAY words LOOP
		INSERT INTO chars
		SELECT c, w
		FROM regexp_split_to_table( w, '' ) c;
	END LOOP;

	RETURN QUERY
	       SELECT c
	       FROM chars
	       GROUP BY c
	       HAVING count( word ) >= array_length( words, 1 );
END
$CODE$
LANGUAGE plpgsql;
