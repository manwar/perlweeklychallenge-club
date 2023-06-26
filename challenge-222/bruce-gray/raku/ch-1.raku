sub task1 ( @ns --> UInt ) {
    return sum( @ns Z== @ns.sort(+*) );
}

my @tests =
    ( (1, 1, 4, 2, 1, 3), 3 ),
    ( (5, 1, 2, 3, 4   ), 0 ),
    ( (1, 2, 3, 4, 5   ), 5 ),
;
use Test;
plan +@tests;
for @tests -> ( @in, $expected ) {
    is task1(@in), $expected;
}
