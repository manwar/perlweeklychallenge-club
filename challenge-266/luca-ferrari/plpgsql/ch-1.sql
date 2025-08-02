--
-- Perl Weekly Challenge 266
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-266>
--

CREATE SCHEMA IF NOT EXISTS pwc266;

CREATE OR REPLACE FUNCTION
pwc266.task1_plpgsql( l text, r text )
RETURNS SETOF text
AS $CODE$

   WITH left_words AS (
   	   SELECT w, count( w ) as c
	   FROM regexp_split_to_table( l, '\W+' ) w
   	   GROUP BY 1
	   )
    , right_words AS (
          SELECT w, count( w ) as c
          FROM regexp_split_to_table( R, '\W+' ) w
          GROUP BY 1
    )

    SELECT w
    FROM left_words
    WHERE w NOT IN ( SELECT w FROM right_words )
    AND c = 1
    UNION
    SELECT w
    FROM right_words
    WHERE w NOT IN ( SELECT w FROM left_words )
    AND c = 1
   ;

$CODE$
LANGUAGE sql;
