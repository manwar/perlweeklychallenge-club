#!/usr/bin/env raku

sub array-pairings (+@list) {
    @list
    andthen .sort
    andthen .map: * min *
    andthen .sum
}

multi MAIN (Bool :test($)!) {
    use Test;
    is array-pairings(1,2,3,4),4;
    is array-pairings(0,2,1,3),2;
    done-testing;
}

multi MAIN (*@list) {
    say array-pairings @list
}
