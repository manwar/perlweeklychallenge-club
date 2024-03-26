--
-- Perl Weekly Challenge 262
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-262>
--

CREATE SCHEMA IF NOT EXISTS pwc262;

CREATE OR REPLACE FUNCTION
pwc262.task1_plpgsql( nums int[] )
RETURNS int
AS $CODE$

   WITH positives AS (
   	SELECT count( v ) as c
	FROM unnest( nums ) v
	WHERE  v >= 0
	), negatives AS (
	SELECT count( v ) as c
	FROM unnest( nums ) v
	WHERE  v < 0
	)
	, b AS (
	  SELECT c as v FROM positives
	  UNION
	  SELECT c as v FROM negatives
	  )
   SELECT max( b.v )
   FROM b;
$CODE$
LANGUAGE sql;
