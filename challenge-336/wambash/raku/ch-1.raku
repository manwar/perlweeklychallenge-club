#!/usr/bin/env raku
use v6.e.PREVIEW;

sub equal-group (+ints) {
    ints
    andthen True, |.rotor( 2 => -1 )
    andthen .snip: { [==] $_ }\
    andthen .map: *.elems
    andthen [gcd] $_
    andthen * > 1
}

multi MAIN (Bool :test($)!) {
    use Test;
    is equal-group(1,1,2,2,2,2), True;
    is equal-group(1,1,1,2,2,2,3,3), False;
    is equal-group(5,5,5,5,5,5,7,7,7,7,7,7), True;
    is equal-group(1..4), False;
    is equal-group(8,8,9,9,10,10,11,11), True;
    done-testing;
}

multi MAIN (+ints) {
    say equal-group ints;
}
