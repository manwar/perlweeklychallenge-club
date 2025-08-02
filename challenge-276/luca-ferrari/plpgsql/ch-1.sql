--
-- Perl Weekly Challenge 276
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-276>
--

CREATE SCHEMA IF NOT EXISTS pwc276;

CREATE OR REPLACE FUNCTION
pwc276.task1_plpgsql( hours int[] )
RETURNS TABLE( l int, r int )
AS $CODE$

   WITH elems AS ( SELECT v::int, row_number() OVER ( ORDER BY v ) AS r
                   FROM unnest( hours ) v
		 )

   SELECT l.v::int, r.v::int
   FROM elems l, elems r
   WHERE mod( ( l.v::int + r.v::int ), 24 ) = 0
   AND   l.r < r. r
   ;

$CODE$
LANGUAGE sql;
