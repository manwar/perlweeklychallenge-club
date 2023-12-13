--
-- Perl Weekly Challenge 247
-- Task 2
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-247/>
--

CREATE SCHEMA IF NOT EXISTS pwc247;

CREATE OR REPLACE FUNCTION
pwc247.task2_plpgsql( string text )
RETURNS TABLE( needle text, repetitions int )
AS $CODE$

DECLARE
	needle text;
BEGIN
	CREATE TEMPORARY TABLE IF NOT EXISTS repetitions( needle text, repetition int );
	TRUNCATE repetitions;

	FOR i IN 1 .. length( string ) LOOP
	    needle := substr( string, i, 2 );

	    INSERT INTO repetitions
	    SELECT needle, ( SELECT count(*) FROM  regexp_matches( string, needle, 'g' )f );

	END LOOP;

	RETURN QUERY
	SELECT *
	FROM repetitions
	ORDER BY repetition DESC
	LIMIT 1;

END
$CODE$
LANGUAGE plpgsql;
