--
-- Perl Weekly Challenge 365
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-365>
--

CREATE SCHEMA IF NOT EXISTS pwc365;

CREATE OR REPLACE FUNCTION
pwc365.task2_plpgsql( s text )
RETURNS int
AS $CODE$
   SELECT count(*)
   FROM   regexp_split_to_table( s, '\s+' ) v
   WHERE  v !~ '[0-9]'
   AND    v !~ '[A-Z]\-'
   AND    v !~ '\-[A-Z]'
   AND    v !~ '[!.,].+'
   ;

$CODE$
LANGUAGE sql;
