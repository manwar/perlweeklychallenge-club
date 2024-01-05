sub task1 ( @ns --> Int ) {
    return @ns.keys.first({ ($_ mod 10) == @ns[$_] }) // -1;
}


constant @tests =
    (  0, (0, 1, 2) ),
    (  2, (4, 3, 2, 1) ),
    ( -1, (1, 2, 3, 4, 5, 6, 7, 8, 9, 0) ),

    ( 11, (1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1) ),
;
use Test; plan +@tests;
for @tests -> ( $expected, @in ) {
    is task1(@in), $expected;
}
