--
-- Perl Weekly Challenge 278
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-278>
--

CREATE SCHEMA IF NOT EXISTS pwc278;

CREATE OR REPLACE FUNCTION
pwc278.task1_plpgsql( words text[] )
RETURNS SETOF text
AS $CODE$

   WITH numbered AS (
      SELECT substring( v::text from '^[a-zA-Z]+' ) as word
           , substring( v::text from '\d+$' )::int as index
      FROM unnest( words ) v
   )
   SELECT word
   FROM numbered
   ORDER BY index
   ;
$CODE$
LANGUAGE sql;
