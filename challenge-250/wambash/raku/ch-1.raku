#!/usr/bin/env raku

sub smallest-index (+ints) {
    ints
    andthen .pairs
    andthen .first: { .key mod 10 == .value  }, :k
}

multi MAIN (Bool :test($)!) {
    use Test;
    is smallest-index(4,3,2,1),2;
    is smallest-index(0,1,2),0;
    is smallest-index(1, 2, 3, 4, 5, 6, 7, 8, 9, 0), Nil;
    is smallest-index(1, 2, 3, 4, 5, 6, 7, 8, 9, 1, 0), 10;
    done-testing;
}

multi MAIN (+ints) {
    say smallest-index( ints ) // -1
}
