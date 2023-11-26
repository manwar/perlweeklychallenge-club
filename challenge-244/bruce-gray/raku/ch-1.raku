sub task1 ( @ns ) {
    return @ns.map: (@ns X< *).sum;
}


constant @tests =
    ( (8, 1, 2, 2, 3) , (4, 0, 1, 1, 3) ),
    ( (6, 5, 4, 8)    , (2, 1, 0, 3) ),
    ( (2, 2, 2)       , (0, 0, 0) ),
;

use Test; plan +@tests;
for @tests -> (@in, @expected) {
    is-deeply task1(@in), @expected;
}
