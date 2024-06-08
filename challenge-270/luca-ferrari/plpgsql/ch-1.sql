--
-- Perl Weekly Challenge 270
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-270>
--

CREATE SCHEMA IF NOT EXISTS pwc270;

CREATE OR REPLACE FUNCTION
pwc270.task1_plpgsql( matrix int[][] )
RETURNS SETOF int[]
AS $CODE$
   SELECT pwc270.task1_plperl( matrix );
$CODE$
LANGUAGE sql;
