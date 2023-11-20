--
-- Perl Weekly Challenge 244
-- Task 2
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-244/>
--

CREATE SCHEMA IF NOT EXISTS pwc244;

CREATE OR REPLACE FUNCTION
pwc244.task2_plpgsql( nums int[] )
RETURNS int
AS $CODE$
   SELECT pwc244.task2_plperl( nums );
$CODE$
LANGUAGE sql;
