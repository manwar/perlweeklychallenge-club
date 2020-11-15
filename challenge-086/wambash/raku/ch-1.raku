#!/usr/bin/env raku


sub pair-difference ( $a, +@n ) {
    @n
    andthen .combinations(2)
    andthen .first: { abs( .[0] - .[1] ) == abs $a }
}

multi MAIN (Bool :$test) {
    use Test;
    is pair-difference( 7, (10, 8, 12, 15, 5)), (8, 15);
    is pair-difference(-7, (10, 8, 12, 15, 5)), (8, 15);
    is pair-difference( 6, (1, 5, 2, 9, 7)), (1, 7);
    is pair-difference(15, (10, 30, 20, 50, 40)), Nil;
}

multi MAIN ($a, +@n) {
    say +so pair-difference $a, @n
}
