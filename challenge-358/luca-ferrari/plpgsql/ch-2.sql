--
-- Perl Weekly Challenge 358
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-358>
--

CREATE SCHEMA IF NOT EXISTS pwc358;

CREATE OR REPLACE FUNCTION
pwc358.task2_plpgsql( s text, i int )
RETURNS text
AS $CODE$
   SELECT pwc358.task2_plperl( s, i );
$CODE$
LANGUAGE sql;
