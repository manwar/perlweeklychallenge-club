#!/usr/bin/env raku

sub MAD (+ints) {
    ints
    andthen .sort
    andthen .rotor: 2 => -1
    andthen .min: {.[1] - .[0]}, :v
}

multi MAIN (Bool :test($)!) {
    use Test;
    is-deeply MAD(1,5,3,8), ((1,3),(3,5));
    is-deeply MAD(4,1,2,3), ((1,2),(2,3),(3,4));
    is-deeply MAD(1,3,7,11,15), ((1,3),);
    done-testing;
}

multi MAIN (+ints) {
    say MAD ints;
}
