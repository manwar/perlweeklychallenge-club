--
-- Perl Weekly Challenge 278
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-278>
--

CREATE SCHEMA IF NOT EXISTS pwc278;

CREATE OR REPLACE FUNCTION
pwc278.task2_plpgsql( w text, c char )
RETURNS text
AS $CODE$

   WITH letters( l, i ) AS (
   	SELECT *
	FROM regexp_split_to_table( w, '' )
	WITH ORDINALITY AS v( text, int )
   )
   , first_part AS (
     SELECT l
     FROM letters
     WHERE i <= position( c IN w )
     ORDER BY l
   )
   , second_part AS (

     SELECT l
     FROM letters
     WHERE i > position( c IN w )
     ORDER BY i
   )
   , all_letters AS (
   SELECT l
   FROM first_part
   UNION ALL
   SELECT l
   FROM second_part
   )
   SELECT string_agg( l, '' )
   FROM all_letters
   ;

$CODE$
LANGUAGE sql;
