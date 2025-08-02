--
-- Perl Weekly Challenge 280
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-280>
--

CREATE SCHEMA IF NOT EXISTS pwc280;

CREATE OR REPLACE FUNCTION
pwc280.task2_plpgsql( s text )
RETURNS int
AS $CODE$

   WITH searching_for AS (
   	SELECT v::text, row_number() over () as r
   	FROM regexp_split_to_table( s, '[|]' ) v
   )
   , data_parts AS (
   	      SELECT v
	      FROM searching_for
	      WHERE r % 2 <> 0
   )
   SELECT sum( length( v ) - length( replace( v, '*', '' ) ) )
   FROM data_parts;

$CODE$
LANGUAGE sql;
