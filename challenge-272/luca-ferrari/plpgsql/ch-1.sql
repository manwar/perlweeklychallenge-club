--
-- Perl Weekly Challenge 272
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-272>
--

CREATE SCHEMA IF NOT EXISTS pwc272;

CREATE OR REPLACE FUNCTION
pwc272.task1_plpgsql( addr text )
RETURNS text
AS $CODE$
   SELECT
   regexp_replace( addr, '\.', '[.]', 'g' );
$CODE$
LANGUAGE plpgsql;
