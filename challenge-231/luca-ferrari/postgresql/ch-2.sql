--
-- Perl Weekly Challenge 231
-- Task 2
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-231/>
--

CREATE SCHEMA IF NOT EXISTS pwc231;

CREATE OR REPLACE FUNCTION
pwc231.task2_plpgsql( passengers text[] )
RETURNS int
AS $CODE$

   WITH ages( a ) as (
     SELECT regexp_matches( v::text, '^\d{10}[MF]([6-9]\d)\d{2}$')::text
     FROM unnest( passengers ) v
   )
   SELECT count(*)
   FROM ages



$CODE$
LANGUAGE sql;
