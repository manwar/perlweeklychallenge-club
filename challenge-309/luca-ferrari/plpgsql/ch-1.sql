--
-- Perl Weekly Challenge 309
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-309>
--

CREATE SCHEMA IF NOT EXISTS pwc309;

CREATE OR REPLACE FUNCTION
pwc309.task1_plpgsql( nums int[] )
RETURNS int
AS $CODE$

   WITH data AS (
   	SELECT v, v - lag( v, 1, v * -10 ) over () AS diff
	FROM unnest( nums ) v
	ORDER BY diff ASC
   )
   SELECT  v
   FROM data

   LIMIT 1;

$CODE$
LANGUAGE sql;
