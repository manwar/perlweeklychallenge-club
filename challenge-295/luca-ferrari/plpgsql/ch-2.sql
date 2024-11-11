--
-- Perl Weekly Challenge 295
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-295>
--

CREATE SCHEMA IF NOT EXISTS pwc295;

CREATE OR REPLACE FUNCTION
pwc295.task2_plpgsql( nums int[] )
RETURNS int
AS $CODE$
   SELECT pwc295.task2_plperl( nums );
$CODE$
LANGUAGE sql;
