#!/usr/bin/env raku

sub maximum-count (+ints) {
    ints
    andthen .map: *.abs
    andthen .max
}

multi MAIN (Bool :test($)!) {
    use Test;
    is maximum-count(-3,-2,-1,1,2,3),3;
    is maximum-count(-2,-1,0,0,1),2;
    is maximum-count(1,2,3,4),4;
    done-testing;
}

multi MAIN (+ints) {
    say maximum-count ints
}
