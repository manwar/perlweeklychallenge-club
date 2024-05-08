--
-- Perl Weekly Challenge 268
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-268>
--

CREATE SCHEMA IF NOT EXISTS pwc268;

CREATE OR REPLACE FUNCTION
pwc268.task2_plpgsql( nums int[] )
RETURNS SETOF int
AS $CODE$
   SELECT pwc268.task2_plperl( nums );
$CODE$
LANGUAGE sql;
