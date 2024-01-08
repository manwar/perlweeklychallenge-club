--
-- Perl Weekly Challenge 249
-- Task 2
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-249/>
--

CREATE SCHEMA IF NOT EXISTS pwc249;

CREATE OR REPLACE FUNCTION
pwc249.task2_plpgsql( s text )
RETURNS int[]
AS $CODE$
   SELECT pwc249.task2_plperl( s );
$CODE$
LANGUAGE plpgsql;
