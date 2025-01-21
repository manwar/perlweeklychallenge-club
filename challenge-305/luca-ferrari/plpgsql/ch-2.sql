--
-- Perl Weekly Challenge 306
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-306>
--

CREATE SCHEMA IF NOT EXISTS pwc306;

CREATE OR REPLACE FUNCTION
pwc306.task2_plpgsql( dictionary char[], words text[] )
RETURNS SETOF text
AS $CODE$
   SELECT pwc306.task2_plperl( dictionary, words );
$CODE$
LANGUAGE sql;
