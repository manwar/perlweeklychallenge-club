--
-- Perl Weekly Challenge 260
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-260>
--

CREATE SCHEMA IF NOT EXISTS pwc260;

CREATE OR REPLACE FUNCTION
pwc260.task1_plpgsql( nums int[] )
RETURNS boolean
AS $CODE$

   WITH numbers AS (
   	SELECT n
	FROM unnest( nums ) n
	)
   , counting AS (
	SELECT n, count(*) AS c
	FROM numbers
	GROUP BY n
	)
   , grouping AS (
     	SELECT c, count(*) AS g
	FROM counting
	GROUP BY c
	)
   SELECT NOT EXISTS( SELECT g
   	      	      FROM grouping
   		      WHERE g > 1
		      );

$CODE$
LANGUAGE sql;
