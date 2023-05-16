--
-- Perl Weekly Challenge 217
-- Task 2
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-217/>
--

CREATE SCHEMA IF NOT EXISTS pwc217;

CREATE OR REPLACE FUNCTION
pwc217.task2_plpgsql( a int[] )
RETURNS int
AS $CODE$
   SELECT string_agg( v.vv::text, '' )::int
   FROM ( SELECT vv
          FROM unnest( a ) vv
	  ORDER BY ( vv % 10 ) DESC  ) v;
$CODE$
LANGUAGE sql;
