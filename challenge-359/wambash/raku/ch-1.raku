#!/usr/bin/env raku

sub digital-root ($int) {
    $int, *.comb.sum ... *.chars == 1
    andthen .end, .tail
}

multi MAIN (Bool :test($)!) {
    use Test;
    is digital-root(38), (2,2);
    is digital-root(7), (0,7);
    is digital-root(999), (2,9);
    is digital-root(1999999999), (3,1);
    is digital-root(101010), (1,3);
    done-testing;
}

multi MAIN ($int) {
    put digital-root $int;
}
