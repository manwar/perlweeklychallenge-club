-- Perl Weekly Challenge 186
-- Task 2

CREATE SCHEMA IF NOT EXISTS pwc186;

CREATE OR REPLACE FUNCTION
pwc186.task2_plpgsql( t text )
RETURNS text
AS $CODE$
BEGIN
        RETURN pwc186.task2_plperl( t );
END
$CODE$
LANGUAGE plpgsql;
