#!/usr/bin/env raku

sub sum-of-values (+ints, :$k!) {
    ints
    andthen .pairs
    andthen .grep: { .key.polymod(2 xx *).sum == $k }\
    andthen .map: *.value
    andthen .sum
}

multi MAIN (Bool :test($)!) {
    use Test;
    is sum-of-values(2,5,9,11,3):k(1),17;
    is sum-of-values(2,5,9,11,3):k(2),11;
    is sum-of-values(2,5,9,11,3):k(0), 2;
    done-testing;
}

multi MAIN (+ints, Int :$k!) {
    say sum-of-values ints, :$k
}
