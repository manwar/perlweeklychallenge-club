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
