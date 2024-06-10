--
-- Perl Weekly Challenge 273
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-273>
--

CREATE SCHEMA IF NOT EXISTS pwc273;

CREATE OR REPLACE FUNCTION
pwc273.task1_plpgsql( s text, c char )
RETURNS int
AS $CODE$

   WITH letters AS ( SELECT v FROM regexp_split_to_table( s, '' ) v )
   , matches AS ( SELECT v FROM letters v WHERE v = c )
   , c_l AS ( SELECT count(*) as x FROM letters )
   , c_m AS ( SELECT count(*) as x FROM matches )
   SELECT m.x::numeric / l.x::numeric * 100
   FROM c_l l , c_m m;

$CODE$
LANGUAGE sql;
