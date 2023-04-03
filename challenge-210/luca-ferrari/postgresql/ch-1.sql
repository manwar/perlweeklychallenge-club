--
-- Perl Weekly Challenge 210
-- Task 1
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-210/>
--

CREATE SCHEMA IF NOT EXISTS pwc210;

CREATE OR REPLACE FUNCTION
pwc210.task1_plpgsql( l int[] )
RETURNS int
AS $CODE$
   SELECT pwc210.task1_plperl( l );
$CODE$
LANGUAGE sql;
