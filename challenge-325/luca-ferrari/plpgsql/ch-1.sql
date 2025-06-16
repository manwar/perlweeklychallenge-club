--
-- Perl Weekly Challenge 325
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-325>
--

CREATE SCHEMA IF NOT EXISTS pwc325;

CREATE OR REPLACE FUNCTION
pwc325.task1_plpgsql( b text )
RETURNS int
AS $CODE$
   SELECT max( length( v::text ) - 2 )
   FROM  regexp_matches( b, '1+', 'g' ) v;
$CODE$
LANGUAGE sql;
