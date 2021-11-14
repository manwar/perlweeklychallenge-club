/*
testdb=> SELECT FRIENDLY( 26, 39 );
friendly
----------
0
(1 row)

testdb=> SELECT FRIENDLY( 26, 52 );
friendly
----------
1
(1 row)

*/
CREATE OR REPLACE FUNCTION friendly( m int, n int )
RETURNS int
AS $CODE$
   SELECT
        CASE gcd( m, n ) % 2
             WHEN 0  THEN 1
             ELSE 0
        END;
$CODE$
LANGUAGE SQL;

