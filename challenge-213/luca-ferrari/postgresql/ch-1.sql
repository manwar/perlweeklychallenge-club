--
-- Perl Weekly Challenge 213
-- Task 1
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-213/>
--

CREATE SCHEMA IF NOT EXISTS pwc213;

CREATE OR REPLACE FUNCTION
pwc213.task1_plpgsql( a int[] )
RETURNS int[]
AS $CODE$
   WITH evens AS (
   SELECT array_agg( v ) as x
   FROM ( SELECT v FROM  unnest( a ) v
          WHERE  v % 2 = 0
          ORDER BY 1
        ) as v
   ), odds AS (
      SELECT array_agg( v ) as x
      FROM  ( SELECT v FROM  unnest( a ) v
              WHERE  v % 2 <> 0
	      ORDER BY  1 ) as v
  )
  SELECT array_cat( e.x, o.x )
  FROM evens e, odds o;

$CODE$
LANGUAGE sql;
