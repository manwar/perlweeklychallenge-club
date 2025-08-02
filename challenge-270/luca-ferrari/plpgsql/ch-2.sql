--
-- Perl Weekly Challenge 270
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-270>
--

CREATE SCHEMA IF NOT EXISTS pwc270;

CREATE OR REPLACE FUNCTION
pwc270.task2_plpgsql( s int, d int, nums int[] )
RETURNS int
AS $CODE$
   SELECT pwc270.task2_plperl( s, d, nums );
$CODE$
LANGUAGE sql;
