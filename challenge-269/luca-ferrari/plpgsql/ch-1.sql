--
-- Perl Weekly Challenge 269
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-269>
--

CREATE SCHEMA IF NOT EXISTS pwc269;

CREATE OR REPLACE FUNCTION
pwc269.task1_plpgsql( nums int[] )
RETURNS SETOF int
AS $CODE$

   SELECT a, b
   FROM unnest( nums ) a
       , unnest( nums ) b
   WHERE
      a <> b
      AND
      mod( a | b, 2 ) = 0;
$CODE$
LANGUAGE sql;
