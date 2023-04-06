--
-- Perl Weekly Challenge 210
-- Task 2
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-210/>
--

CREATE SCHEMA IF NOT EXISTS pwc210;

CREATE OR REPLACE FUNCTION
pwc210.task2_plpgsql( l int[] )
RETURNS SETOF int
AS $CODE$
   SELECT pwc210.task2_plperl( l );
$CODE$
LANGUAGE sql;
