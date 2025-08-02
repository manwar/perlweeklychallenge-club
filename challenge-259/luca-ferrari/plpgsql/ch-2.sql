--
-- Perl Weekly Challenge 259
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-259>
--

CREATE SCHEMA IF NOT EXISTS pwc259;

CREATE OR REPLACE FUNCTION
pwc259.task2_plpgsql( line text )
RETURNS TABLE( id text, field_name text, field_value text )
AS $CODE$
   SELECT pwc259.task2_plperl( line );
$CODE$
LANGUAGE sql;
