--
-- Perl Weekly Challenge 238
-- Task 1
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-238/>
--

CREATE SCHEMA IF NOT EXISTS pwc238;

CREATE OR REPLACE FUNCTION
pwc238.task1_plpgsql( nums int[] )
RETURNS TABLE( v int, s int )
AS $CODE$

   SELECT v, sum( v ) OVER ( ORDER BY v )
   FROM unnest( nums ) v;
$CODE$
LANGUAGE sql;
