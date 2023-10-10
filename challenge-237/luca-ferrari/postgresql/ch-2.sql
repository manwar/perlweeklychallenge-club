--
-- Perl Weekly Challenge 237
-- Task 2
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-237/>
--

CREATE SCHEMA IF NOT EXISTS pwc237;

CREATE OR REPLACE FUNCTION
pwc237.task2_plpgsql( nums int[] )
RETURNS int
AS $CODE$
	SELECT pwc237.task2_plperl( nums );
$CODE$
LANGUAGE sql;
