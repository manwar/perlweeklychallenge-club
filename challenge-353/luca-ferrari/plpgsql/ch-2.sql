--
-- Perl Weekly Challenge 353
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-353>
--

CREATE SCHEMA IF NOT EXISTS pwc353;

CREATE OR REPLACE FUNCTION
pwc353.task2_plpgsql( c text[], n text[], s text[] )
RETURNS SETOF text
AS $CODE$
   SELECT pwc353.task2_plperl( c, n, s );

$CODE$
LANGUAGE sql;
