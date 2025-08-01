--
-- Perl Weekly Challenge 332
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-332>
--

CREATE SCHEMA IF NOT EXISTS pwc332;

CREATE OR REPLACE FUNCTION
pwc332.task2_plpgsql( t text )
RETURNS boolean
AS $CODE$
   select NOT exists(
   	  select v
	  from regexp_split_to_table( t, '' ) v
	  group by v
	  having count(*) > 1 );
$CODE$
LANGUAGE sql;
