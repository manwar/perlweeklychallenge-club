--
-- Perl Weekly Challenge 257
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-257>
--

CREATE SCHEMA IF NOT EXISTS pwc257;

CREATE OR REPLACE FUNCTION
pwc257.task2_plpgsql( matrix int[] )
RETURNS bool
AS $CODE$
	select pwc257.task2_plperl( matrix );
$CODE$
LANGUAGE sql;
