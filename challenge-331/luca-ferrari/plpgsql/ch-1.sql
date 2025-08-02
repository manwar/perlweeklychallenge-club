--
-- Perl Weekly Challenge 331
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-331>
--

CREATE SCHEMA IF NOT EXISTS pwc331;

CREATE OR REPLACE FUNCTION
pwc331.task1_plpgsql( s text )
RETURNS int
AS $CODE$

   SELECT l
   FROM (
	SELECT length( v::text ) as l, row_number() over () as r
	FROM regexp_split_to_table( s, '\s+' ) v
	WHERE length( v::text ) > 0
	ORDER BY r DESC
	)
   LIMIT 1;


$CODE$
LANGUAGE sql;
