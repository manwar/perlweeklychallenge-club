--
-- Perl Weekly Challenge 200
-- Task 2
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-200/>
--

CREATE SCHEMA IF NOT EXISTS pwc200;

CREATE OR REPLACE FUNCTION
pwc200.task2_plpgsql( v int )
RETURNS text
AS $CODE$
   SELECT pwc200.task2_plperl( v );
$CODE$
LANGUAGE sql;
