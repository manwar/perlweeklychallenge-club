-- Perl Weekly Challenge 160

CREATE SCHEMA IF NOT EXISTS pwc160;

CREATE OR REPLACE FUNCTION
pwc160.equilibrium_plpgsql( A int[] )
RETURNS int
AS $CODE$
DECLARE
   sum_a int;
   sum_b int;
BEGIN
    FOR idx IN 1 .. array_length( A, 1 )  LOOP
        SELECT sum( n )
        INTO sum_a
        FROM unnest( A[ 0 : idx - 1 ] ) n;

        SELECT sum( n )
        INTO sum_b
        FROM unnest( A[ idx : array_length( A, 1 ) ] ) n;

        IF sum_a = sum_b THEN
           RETURN idx;
        END IF;
    END LOOP;

    RETURN -1;
END
$CODE$
LANGUAGE plpgsql;
