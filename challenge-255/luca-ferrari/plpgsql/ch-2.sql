--
-- Perl Weekly Challenge 255
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-255>
--

CREATE SCHEMA IF NOT EXISTS pwc255;

CREATE OR REPLACE FUNCTION
pwc255.task2_plpgsql( p text, b text )
RETURNS SETOF text
AS $CODE$
DECLARE

BEGIN
	CREATE TEMPORARY TABLE IF NOT EXISTS classification( w text );
	TRUNCATE TABLE classification;

	INSERT INTO classification
	SELECT v
	FROM regexp_split_to_table( p, '\W+' ) v;

	RETURN QUERY
	       SELECT w FROM (
	       	 SELECT w, count(*) AS c
	       	 FROM classification
	       	 WHERE w <> b
	       	 GROUP BY w
	       	 ORDER BY c DESC
	       	 LIMIT 1
	       );

END
$CODE$
LANGUAGE plpgsql;
