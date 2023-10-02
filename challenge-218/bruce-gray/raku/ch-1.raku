sub task1 ( @ns ) {
    return @ns.combinations(3).map({ [*] .list }).max;
    # No time this week for efficient logic.
}


my @tests =
    (   6, (  3,  1,  2)            ),
    (  24, (  4,  1,  3,  2)        ),
    (   3, ( -1,  0,  1,  3,  1)    ),
    ( 216, ( -8,  2, -9,  0, -4, 3) ),
;
use Test;
plan +@tests;
for @tests -> ( $expected, @in ) {
    is task1(@in), $expected;
}
