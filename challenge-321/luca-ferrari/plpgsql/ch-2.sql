--
-- Perl Weekly Challenge 321
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-321>
--

CREATE SCHEMA IF NOT EXISTS pwc321;

CREATE OR REPLACE FUNCTION
pwc321.task2_plpgsql( l text, r text )
RETURNS boolean
AS $CODE$
   SELECT regexp_replace( l, '.[#]', '', 'g' ) = regexp_replace( r, '.[#]', '', 'g' );
$CODE$
LANGUAGE sql;
