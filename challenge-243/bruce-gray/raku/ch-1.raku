sub task1 ( @ns ) {
    sub is_reverse_pair ( [$left, $right] ) { $left > ($right * 2) }

    return +grep &is_reverse_pair,
            combinations(@ns, 2);
}


constant @tests =
    ( 2, (1, 3, 2, 3, 1) ),
    ( 3, (2, 4, 3, 5, 1) ),
;
use Test; plan +@tests;
for @tests -> ($expected, @ns) {
    is task1(@ns), $expected;
}
