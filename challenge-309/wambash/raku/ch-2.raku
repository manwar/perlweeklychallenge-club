#!/usr/bin/env raku

sub min-diff (+ints) {
    ints
    andthen .sort
    andthen .rotor: 2=>-1
    andthen .map: {[-] .reverse}\
    andthen .min
}

multi MAIN (Bool :test($)!) {
    use Test;
    is min-diff(1,5,8,9),1;
    is min-diff(9,4,1,7),2;
    done-testing;
}

multi MAIN (+ints) {
    say min-diff ints
}
