--
-- Perl Weekly Challenge 260
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-260>
--

CREATE SCHEMA IF NOT EXISTS pwc260;

CREATE OR REPLACE FUNCTION
pwc260.task2_plpgsql( w text )
RETURNS int
AS $CODE$
   SELECT pwc260.task2_plperl( w );
$CODE$
LANGUAGE ùsql;
