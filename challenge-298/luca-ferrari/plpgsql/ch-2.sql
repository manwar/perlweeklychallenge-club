--
-- Perl Weekly Challenge 298
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-298>
--

CREATE SCHEMA IF NOT EXISTS pwc298;

CREATE OR REPLACE FUNCTION
pwc298.task2_plpgsql( intervals int[][] )
RETURNS int[]
AS $CODE$
   SELECT pwc298.task2_plperl( intervals );
$CODE$
LANGUAGE sql;
