--
-- Perl Weekly Challenge 251
-- Task 2
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-251/>
--

CREATE SCHEMA IF NOT EXISTS pwc251;

CREATE OR REPLACE FUNCTION
pwc251.task2_plpgsql( matrix int[][] )
RETURNS int
AS $CODE$
   SELECT pwc251.task2_plperl( matrix );
$CODE$
LANGUAGE sql;
