--
-- Perl Weekly Challenge 257
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-257>
--

CREATE SCHEMA IF NOT EXISTS pwc257;

CREATE OR REPLACE FUNCTION
pwc257.task1_plpgsql( numbers int[] )
RETURNS SETOF int
AS $CODE$
   select z
   from unnest( numbers ) v,
        lateral ( select count(x)
	          from unnest( numbers ) x
		  WHERE x < v ) as y(z);
$CODE$
LANGUAGE sql;
