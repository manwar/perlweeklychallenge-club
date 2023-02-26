sub task1 ( @ns ) {
    return (.elems == 3 ?? .head !! .tail) given @ns.sort.squish.tail(3);
}


my @tests =
    ( ( 5, 3, 4    ), 3 ), #  5 4 3
    ( ( 5, 6       ), 6 ), #  6 5 * Third highest is missing, so maximum is returned.
    ( ( 5, 4, 4, 3 ), 3 ), #  5 4 3 (Aha! ties!)
;
use Test;
plan +@tests;
is task1(.[0]), .[1] for @tests;
