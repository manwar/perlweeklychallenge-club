sub task1 { @^in»².sort }


my @tests =
    ( ( -2, -1,  0, 3, 4 ) , ( 0, 1,  4,  9, 16 ) ),
    ( (  5, -4, -1, 3, 6 ) , ( 1, 9, 16, 25, 36 ) ),
;
use Test;
plan +@tests;
for @tests -> ( $in, $expected ) {
    is-deeply task1($in), $expected;
}
