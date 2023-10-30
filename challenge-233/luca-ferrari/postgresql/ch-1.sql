--
-- Perl Weekly Challenge 233
-- Task 1
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-233/>
--

CREATE SCHEMA IF NOT EXISTS pwc233;

CREATE OR REPLACE FUNCTION
pwc233.task1_plpgsql( words text[] )
RETURNS SETOF text
AS $CODE$
DECLARE
	current_word text;
BEGIN
	CREATE TEMPORARY TABLE IF NOT EXISTS sorting( key text, word text );
	TRUNCATE sorting;

	FOREACH current_word IN ARRAY words LOOP
		INSERT INTO sorting( key, word )
		SELECT string_agg( k::text, '' )::text, current_word
		FROM ( SELECT v::text
		       FROM regexp_split_to_table( current_word, '' ) v
		       ORDER BY 1
		     ) k
	       ;
	END LOOP;

	RETURN QUERY
	       SELECT word
	       FROM   sorting
	       WHERE  key IN ( SELECT key
	       	      	       FROM sorting
			       GROUP BY key
			       HAVING COUNT(*) > 1 );

END
$CODE$
LANGUAGE plpgsql;
