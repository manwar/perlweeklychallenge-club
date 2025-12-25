--
-- Perl Weekly Challenge 353
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-353>
--

CREATE SCHEMA IF NOT EXISTS pwc353;

CREATE OR REPLACE FUNCTION
pwc353.task1_plpgsql( s text[] )
RETURNS int
AS $CODE$
   SELECT max( regexp_count( x, '\w+' ) )
   FROM   unnest( s ) x;

$CODE$
LANGUAGE sql;
