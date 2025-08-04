--
-- Perl Weekly Challenge 333
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-333>
--

CREATE SCHEMA IF NOT EXISTS pwc333;

CREATE OR REPLACE FUNCTION
pwc333.task1_plpgsql( c int[] )
RETURNS boolean
AS $CODE$
   SELECT pwc333.task1_plperl( c );
$CODE$
LANGUAGE sql;
