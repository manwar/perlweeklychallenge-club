#!/usr/bin/env raku

sub max-gap (+@list) {
    @list
    andthen .sort
    andthen .rotor: 2 => -1
    andthen .map: -> ($a, $b) { $b - $a }\
    andthen .maxpairs
    andthen .elems
}

multi MAIN (Bool :test($)!) {
    use Test;
    is max-gap(2,5,8,1),2;
    is max-gap(3),0;
    done-testing;
}

multi MAIN (+@list) {
    say max-gap @list
}
