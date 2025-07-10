--
-- Perl Weekly Challenge 329
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-329>
--

CREATE SCHEMA IF NOT EXISTS pwc329;

CREATE OR REPLACE FUNCTION
pwc329.task1_plpgsql( s text )
RETURNS SETOF text
AS $CODE$
   SELECT distinct( v )
   FROM regexp_matches( s, '\d+', 'g' ) v
   ORDER BY 1
$CODE$
LANGUAGE sql;
