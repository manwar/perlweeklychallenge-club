-- Perl Weekly Challenge 183
-- Task 1

CREATE SCHEMA IF NOT EXISTS pwc183;

CREATE OR REPLACE FUNCTION
pwc183.task1_plpgsql()
RETURNS int[]
AS $CODE$
   SELECT pwc183.task1_plperl();
$CODE$
LANGUAGE sql;
