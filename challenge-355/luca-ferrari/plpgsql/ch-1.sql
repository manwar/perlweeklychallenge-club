--
-- Perl Weekly Challenge 355
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-355>
--

CREATE SCHEMA IF NOT EXISTS pwc355;

CREATE OR REPLACE FUNCTION
pwc355.task1_plpgsql( n int )
RETURNS text
AS $CODE$
   SELECT regexp_replace( to_char( n,
   	  	   	  	   'FM999,999,999' ),
			 ',',
			 '.',
			 'g' );
$CODE$
LANGUAGE sql;
