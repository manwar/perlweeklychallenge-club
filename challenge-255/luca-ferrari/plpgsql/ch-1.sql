--
-- Perl Weekly Challenge 255
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-255>
--

CREATE SCHEMA IF NOT EXISTS pwc255;

CREATE OR REPLACE FUNCTION
pwc255.task1_plpgsql( origin text, shuffled text )
RETURNS char
AS $CODE$
   SELECT s
   FROM regexp_split_to_table( shuffled, '' ) s
   WHERE s NOT IN ( SELECT v
                    FROM regexp_split_to_table( origin, '' ) v );
$CODE$
LANGUAGE sql;
