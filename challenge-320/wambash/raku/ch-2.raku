#!/usr/bin/env raku

sub sum-difference (+ints) {
    ints
    andthen .map: { $_ - .comb.sum }\
    andthen .sum
}

multi MAIN (Bool :test($)!) {
    use Test;
    is sum-difference(1,23,4,5),18;
    is sum-difference(1..5),0;
    is sum-difference(1,2,34),27;
    done-testing;
}

multi MAIN (+ints) {
    say sum-difference ints
}
