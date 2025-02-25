#!/usr/bin/env raku

sub min-gap (+ints) {
    ints
    andthen .rotor: 2 => -1
    andthen .min: {[-] .reverse}\
    andthen .tail
}

multi MAIN (Bool :test($)!) {
    use Test;
    is min-gap(2,8,10,11,15),11;
    is min-gap(1,5,6,7,14),6;
    is min-gap(8,20,25,28), 28;
    done-testing;
}

multi MAIN (+ints) {
    say min-gap ints
}
