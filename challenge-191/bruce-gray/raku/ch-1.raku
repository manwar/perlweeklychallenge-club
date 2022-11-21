sub task1 (@a) { .[0] >= 2 * .[1] ?? 1 !! -1 given @a.sort(-*) }

my @tests =
    # Examples from task:
    ( ( 1, 2, 3, 4 ), -1 ),
    ( ( 1, 2, 0, 5 ),  1 ),
    ( ( 2, 6, 3, 1 ),  1 ),
    ( ( 4, 5, 2, 3 ), -1 ),

    # Test case that trips up other's solutions, which grep-out the max().
    ( ( 25, 25, 10 ), -1 ),
;
use Test;
plan +@tests;
for @tests -> ( $in, $expected ) {
    is task1($in), $expected;
}
