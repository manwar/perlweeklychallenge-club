--
-- Perl Weekly Challenge 219
-- Task 1
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-219/>
--

CREATE SCHEMA IF NOT EXISTS pwc219;

CREATE OR REPLACE FUNCTION
pwc219.task1_plpgsql( n int[] )
RETURNS SETOF int
AS $CODE$
   SELECT v * v
   FROM unnest( n ) v
   ORDER BY 1
$CODE$
LANGUAGE sql;
