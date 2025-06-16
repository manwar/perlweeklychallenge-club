--
-- Perl Weekly Challenge 326
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-326>
--

CREATE SCHEMA IF NOT EXISTS pwc326;

CREATE OR REPLACE FUNCTION
pwc326.task1_plpgsql( d date )
RETURNS int
AS $CODE$
   SELECT 1 +
          d -
	  ( extract( year from d ) || '-01-01' )::date;
$CODE$
LANGUAGE sql;
