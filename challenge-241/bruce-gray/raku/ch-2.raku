use Prime::Factor;
sub task2 ( @ns --> Seq ) {
    return @ns.sort: { .&prime-factors.elems, +$_ };
}


constant @tests =
    ( (11, 8, 27, 4), (11, 4, 8, 27) ),
;
use Test; plan +@tests;
for @tests -> ( @in, @expected ) {
    is-deeply task2(@in), @expected;
}
