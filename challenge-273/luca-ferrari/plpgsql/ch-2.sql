--
-- Perl Weekly Challenge 273
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-273>
--

CREATE SCHEMA IF NOT EXISTS pwc273;

CREATE OR REPLACE FUNCTION
pwc273.task2_plpgsql( s text )
RETURNS boolean
AS $CODE$

   WITH has_b AS ( SELECT v FROM regexp_count( s, 'b' ) v )
   , has_b_without_trailing_a AS ( SELECT v FROM regexp_count( s, 'b.*a' ) v )
   SELECT CASE b.v WHEN NULL THEN false ELSE true END
   FROM has_b b, has_b_without_trailing_a a
   WHERE a.v = 0 AND b.v >= 1;

$CODE$
LANGUAGE sql;
