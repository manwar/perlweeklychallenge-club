-- Perl Weekly Challenge 170
-- Task 2

CREATE SCHEMA IF NOT EXISTS pwc170;

CREATE OR REPLACE FUNCTION
pwc170.task2_plpgsql( ta text, tb text )
RETURNS TABLE ( a int, b int, c int, d int )
AS $CODE$
DECLARE
BEGIN
        RETURN QUERY
        EXECUTE format( 'SELECT a.a * b.a, a.a * b.b, a.b * b.a, a.b * b.b FROM %I a, %I b',
                        ta, tb );
END
$CODE$
LANGUAGE plpgsql;
