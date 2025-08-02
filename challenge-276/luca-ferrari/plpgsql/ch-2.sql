--
-- Perl Weekly Challenge 276
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-276>
--

CREATE SCHEMA IF NOT EXISTS pwc276;

CREATE OR REPLACE FUNCTION
pwc276.task2_plpgsql( nums int[] )
RETURNS int
AS $CODE$
   WITH freq AS (
   	SELECT count( v ) as frequency, v
   	FROM unnest( nums ) v
   	GROUP BY v
   )
   , max_freq AS ( SELECT frequency FROM freq
                   ORDER BY 1 DESC
		   LIMIT 1
		 )
	SELECT count( f )
	FROM   freq f
	WHERE f.frequency = ( SELECT frequency FROM max_freq )

   ;
$CODE$
LANGUAGE sql;
