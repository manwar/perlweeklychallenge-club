<<<<<<< HEAD
CREATE OR REPLACE FUNCTION task1( a int, b int )
  RETURNS int
AS $CODE$
  SELECT gcd( a, b ) % 2;
  $CODE$
    LANGUAGE SQL;

/*
  Example of invocation:

  testdb=> SELECT task1( 8, 24 ) as a8_24, task1( 26, 39 ) as a26_39, task1( 4, 10 ) as a4_10;
  -[ RECORD 1 ]
  a8_24  | 0
  a26_39 | 1
  a4_10  | 0
*/
=======
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
>>>>>>> dfcf558b2190d45a5ebf3c486a7c316dbc3e197e
