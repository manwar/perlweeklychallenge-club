sub task2 ( @ns ) {
    return @ns.Bag
              .values
              .combinations(3)
              .map({ [*] .list })
              .sum;
}


my @tests =
    (  3, (4, 4, 2, 4, 3) ),
    (  0, (1, 1, 1, 1, 1) ),
    ( 28, (4, 7, 1, 10, 7, 4, 1, 1) ),
    (  0, (4, 4) ),
;
use Test; plan +@tests;
for @tests -> ( $expected, @in ) {
    is task2(@in), $expected;
}
