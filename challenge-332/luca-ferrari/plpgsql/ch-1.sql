--
-- Perl Weekly Challenge 332
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-332>
--

CREATE SCHEMA IF NOT EXISTS pwc332;

CREATE OR REPLACE FUNCTION
pwc332.task1_plpgsql( d date )
RETURNS text
AS $CODE$
   SELECT string_agg( v::int::bit( 8 )::text, '-' )
   FROM   regexp_split_to_table( d::text, '-' ) v;

$CODE$
LANGUAGE sql;
