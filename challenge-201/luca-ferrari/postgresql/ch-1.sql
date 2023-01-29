--
-- Perl Weekly Challenge 201
-- Task 1
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-201/>
--

CREATE SCHEMA IF NOT EXISTS pwc201;

CREATE OR REPLACE FUNCTION
pwc201.task1_plpgsql( n int[] )
RETURNS SETOF int
AS $CODE$
   SELECT v
   FROM generate_series( 1, array_length( n, 1 ) ) v
   WHERE v NOT IN
   ( SELECT unnest( n ) );
$CODE$
LANGUAGE sql;
