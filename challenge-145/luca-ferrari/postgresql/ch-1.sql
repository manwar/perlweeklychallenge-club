/*
testdb=> select f_dot_product( array[1,2,3], array[4,5,6] );
f_dot_product
---------------
32
*/
CREATE OR REPLACE FUNCTION
f_dot_product( a int[], b int[] )
RETURNS int
AS
$CODE$
DECLARE
        i int;
        total int := 0;
BEGIN
        FOR i IN 1 .. array_length( a, 1 ) LOOP
            total := total + a[ i ] * b[ i ];
        END LOOP;

        RETURN total;
END
$CODE$
LANGUAGE plpgsql;
