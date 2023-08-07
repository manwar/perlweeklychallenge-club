--
-- Perl Weekly Challenge 228
-- Task 1
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-228/>
--

CREATE SCHEMA IF NOT EXISTS pwc228;

CREATE OR REPLACE FUNCTION
pwc228.task1_plpgsql( a int[] )
RETURNS int
AS $CODE$
   WITH BAG as (
      SELECT v
      FROM unnest( a ) v
      GROUP BY v
      HAVING count(*) = 1
   )
   SELECT sum( v )
   FROM bag;
$CODE$
LANGUAGE sql;
