--
-- Perl Weekly Challenge 369
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-369>
--

CREATE SCHEMA IF NOT EXISTS pwc369;

CREATE OR REPLACE FUNCTION
pwc369.task2_plpgsql( t text, s int, f text )
RETURNS SETOF text
AS $CODE$
   SELECT pwc369.task2_plperl( t, s, f );
$CODE$
LANGUAGE sql;
