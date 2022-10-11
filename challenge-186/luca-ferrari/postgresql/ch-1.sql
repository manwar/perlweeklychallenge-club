-- Perl Weekly Challenge 186
-- Task 1

CREATE SCHEMA IF NOT EXISTS pwc186;

/*

testdb=# select pwc186.task1_plpgsql( array['a', 'b', 'c']::text[], array['1','2','3']::text[] );
task1_plpgsql
---------------
{a,1,b,2,c,3}

*/
CREATE OR REPLACE FUNCTION
pwc186.task1_plpgsql( l text[], r text[] )
RETURNS text[]
AS $CODE$
DECLARE
        res text[];

BEGIN
        FOR i IN 1 .. array_length( l, 1 ) LOOP
            res := array_append( res, l[ i ] );
            res := array_append( res, r[ i ] );
        END LOOP;

        RETURN res;
END
$CODE$
LANGUAGE plpgsql;
