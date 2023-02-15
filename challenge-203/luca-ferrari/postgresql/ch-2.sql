--
-- Perl Weekly Challenge 203
-- Task 2
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-203/>
--

CREATE SCHEMA IF NOT EXISTS pwc203;

CREATE OR REPLACE FUNCTION
pwc203.task2_plpgsql( src text, dst text )
RETURNS VOID
AS $CODE$
BEGIN
	SELECT pwc203.task2_plperl( src, dst );
END
$CODE$
LANGUAGE plpgsql;
