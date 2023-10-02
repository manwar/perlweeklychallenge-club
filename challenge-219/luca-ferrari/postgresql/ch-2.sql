--
-- Perl Weekly Challenge 219
-- Task 2
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-219/>
--

CREATE SCHEMA IF NOT EXISTS pwc219;

CREATE OR REPLACE FUNCTION
pwc219.task2_plpgsql( c int[], days int[] )
RETURNS int
AS $CODE$
   SELECT pwc219.task2_plperl( c, days );
$CODE$
LANGUAGE sql;
