--
-- Perl Weekly Challenge 217
-- Task 1
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-217/>
--

CREATE SCHEMA IF NOT EXISTS pwc217;

CREATE OR REPLACE FUNCTION
pwc217.task1_plpgsql( a int[] )
RETURNS int
AS $CODE$
   SELECT v
   FROM unnest( a ) v
   ORDER BY 1
   LIMIT 1
   OFFSET 3;
$CODE$
LANGUAGE sql;
