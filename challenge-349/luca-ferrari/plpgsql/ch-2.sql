--
-- Perl Weekly Challenge 349
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-349>
--

CREATE SCHEMA IF NOT EXISTS pwc349;

CREATE OR REPLACE FUNCTION
pwc349.task2_plpgsql( directions text )
RETURNS boolean
AS $CODE$

   WITH moves AS (
   	SELECT v, count( * ) as c
	FROM regexp_split_to_table( directions, '' ) v
	GROUP BY 1
   )
   , summary AS (
       SELECT m1.c - m2.c AS h, m3.c - m4.c AS v
       FROM moves m1, moves m2, moves m3, moves m4
       WHERE
       m1.v = 'L' AND m2.v = 'R'
       AND m3.v = 'U' AND m4.v = 'D'
    )
    SELECT exists (
    	   SELECT *
	   FROM summary
	   WHERE h = 0 AND v = 0
    );


$CODE$
LANGUAGE sql;
