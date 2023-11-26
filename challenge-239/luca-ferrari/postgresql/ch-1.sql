--
-- Perl Weekly Challenge 239
-- Task 1
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-239/>
--

CREATE SCHEMA IF NOT EXISTS pwc239;

CREATE OR REPLACE FUNCTION
pwc239.task1_plpgsql( w1 text[], w2 text[] )
RETURNS boolean
AS $CODE$

SELECT
	array_to_string( w1, '' ) = array_to_string( w2, '' );
$CODE$
LANGUAGE sql;
