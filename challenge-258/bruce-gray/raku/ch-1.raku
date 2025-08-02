sub task1 ( @ns --> UInt ) {
    return +grep { .abs.chars %% 2 }, @ns;
}


use Test; plan +my @tests =
    ( 3, (  10, 1,   111,  24, 1000 ) ),
    ( 0, ( 111, 1, 11111            ) ),
    ( 1, (   2, 8,  1024, 256       ) ),
;
for @tests -> ( $expected, @in ) {
    is task1(@in), $expected;
}
