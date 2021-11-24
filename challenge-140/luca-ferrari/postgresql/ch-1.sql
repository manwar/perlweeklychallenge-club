/**
* Example
testdb=> select f_sum_bits( 10::bit( 10 ), 20::bit( 10 ) );
f_sum_bits
------------
0000011110
(1 row)

*/
CREATE OR REPLACE FUNCTION f_sum_bits( a bit(10), b bit(10) )
RETURNS text
AS $CODE$
   SELECT   ( a::int
            + b::int )::bit( 10 );

$CODE$
LANGUAGE sql;
