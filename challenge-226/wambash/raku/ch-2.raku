#!/usr/bin/env raku

sub zero-array (+ints) {
    ints
    andthen .grep: * !== 0
    andthen .unique
    andthen .elems
}

multi MAIN (Bool :test($)!) {
    use Test;
    is zero-array(1,5,0,3,5),3;
    is zero-array(0),0;
    is zero-array(2,1,4,0,3),4;
    done-testing;
}

multi MAIN (+ints) {
    say zero-array ints
}
