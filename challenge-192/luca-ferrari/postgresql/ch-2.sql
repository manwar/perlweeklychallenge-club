-- Perl Weekly Challenge 192
-- Task 2

CREATE SCHEMA IF NOT EXISTS pwc192;

CREATE OR REPLACE FUNCTION
pwc192.task2_plpgsql( n int[] )
RETURNS int
AS $CODE$
   SELECT pwc192.task2_plperl( n );
$CODE$
LANGUAGE sql;
