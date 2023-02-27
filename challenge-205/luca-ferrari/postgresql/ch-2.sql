--
-- Perl Weekly Challenge 205
-- Task 2
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-205/>
--

CREATE SCHEMA IF NOT EXISTS pwc205;

CREATE OR REPLACE FUNCTION
pwc205.task2_plpgsql( l int[] )
RETURNS int
AS $CODE$
   SELECT pwc205.task2_plperl( l );
$CODE$
LANGUAGE sql;
