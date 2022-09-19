-- Perl Weekly Challenge 171
-- Task 2

CREATE SCHEMA IF NOT EXISTS pwc171;

CREATE OR REPLACE FUNCTION
pwc171.task2_plpgsql( f text DEFAULT 'pwc171.task2_f',
                      g text DEFAULT 'pwc171.task2_g',
                      v text DEFAULT 'PWC 171' )
RETURNS SETOF TEXT
AS $CODE$
BEGIN
        RETURN QUERY
        EXECUTE format( 'SELECT * FROM %s( %s( $$%s$$ ) )', f, g, v );
END
$CODE$
LANGUAGE plpgsql;
