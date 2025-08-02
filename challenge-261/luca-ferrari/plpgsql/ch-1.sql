--
-- Perl Weekly Challenge 261
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-261>
--

CREATE SCHEMA IF NOT EXISTS pwc261;

CREATE OR REPLACE FUNCTION
pwc261.task1_plpgsql( nums int[] )
RETURNS int
AS $CODE$

WITH sum_numbers AS ( SELECT SUM( n::int ) AS y FROM unnest( nums ) n )
     , digits AS ( SELECT regexp_split_to_table( n::text, '' ) d
       	      	   FROM unnest( nums ) n )
      , sum_digits AS ( SELECT SUM( d::int ) AS x FROM digits d )
     , result AS ( SELECT y - x AS r
                   FROM sum_numbers, sum_digits )

     SELECT CASE WHEN r > 0 THEN r
            ELSE r * -1
	    END

    FROM result;
$CODE$
LANGUAGE sql;
