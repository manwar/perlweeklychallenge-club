--
-- Perl Weekly Challenge 357
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-357>
--

CREATE SCHEMA IF NOT EXISTS pwc357;

CREATE OR REPLACE FUNCTION
pwc357.task1_plpgsql( n int )
RETURNS int
AS $CODE$
DECLARE
	k int := 6174;
	i int := 0;
BEGIN
	WHILE n <> k LOOP
	      i := i + 1;

	      with digits_asc as (
	           select v
		   from   regexp_split_to_table( n::text, '' ) v
		   order by v asc
		  ),
		  digits_desc as (
		   select v
		   from   regexp_split_to_table( n::text, '' ) v
		   order by v desc
		  ),
		  a as ( select array_to_string( array_agg( a.v ), '' )::int v
		         from digits_asc a
		       ),
		  d as ( select array_to_string( array_agg( d.v ), '' )::int v
		         from digits_desc d
		       )
             select d.v - a.v
	     into n
	     from d d, a a;

	END LOOP;

	RETURN i;

END
$CODE$
LANGUAGE plpgsql;
