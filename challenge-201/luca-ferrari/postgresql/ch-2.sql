--
-- Perl Weekly Challenge 201
-- Task 2
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-201/>
--

CREATE SCHEMA IF NOT EXISTS pwc201;

CREATE OR REPLACE FUNCTION
pwc201.task2_plpgsql( n int )
RETURNS int
AS $CODE$
   SELECT pwc201.task2_plperl( n );
$CODE$
LANGUAGE sql;
