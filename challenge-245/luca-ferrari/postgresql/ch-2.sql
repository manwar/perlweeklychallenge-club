--
-- Perl Weekly Challenge 245
-- Task 2
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-245/>
--

CREATE SCHEMA IF NOT EXISTS pwc245;

CREATE OR REPLACE FUNCTION
pwc245.task2_plpgsql( digits int[] )
RETURNS int
AS $CODE$
   SELECT pwc245.task2_plperl( digits );
$CODE$
LANGUAGE sql;
