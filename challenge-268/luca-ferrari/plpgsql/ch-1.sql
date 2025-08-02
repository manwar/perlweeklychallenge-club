--
-- Perl Weekly Challenge 268
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-268>
--

CREATE SCHEMA IF NOT EXISTS pwc268;

CREATE OR REPLACE FUNCTION
pwc268.task1_plpgsql( l int[], r int[] )
RETURNS int
AS $CODE$

   WITH sorted_left AS ( SELECT v, row_number()  OVER ( order by 1 ) as r  FROM unnest( l ) v  )
   , sorted_right AS ( SELECT v, row_number()  OVER ( order by 1 ) as r  FROM unnest( r ) v  )
   , diffs AS (
   SELECT l.v - r.v as d
   FROM sorted_left l, sorted_right r
   WHERE l.r = r.r
   )
   SELECT d
   FROM diffs d
   GROUP BY d
   HAVING count(*) = ( SELECT array_length( l, 1 ) );


$CODE$
LANGUAGE sql;
