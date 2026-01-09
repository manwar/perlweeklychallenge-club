--
-- Perl Weekly Challenge 355
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-355>
--

CREATE SCHEMA IF NOT EXISTS pwc355;

CREATE OR REPLACE FUNCTION
pwc355.task2_plpgsql( v int[] )
RETURNS boolean
AS $CODE$
   SELECT pwc355.task2_plperl( v );
$CODE$
LANGUAGE sql;
