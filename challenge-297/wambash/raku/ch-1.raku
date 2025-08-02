#!/usr/bin/env raku

sub contigus-array (+binary) {
    [\,] binary
    andthen .map: {
        $_, *.skip.cache ... :!elems
        andthen .first: {  $_.sum ==  .elems / 2}
    }\
    andthen .map: *.elems
    andthen .max
}

multi MAIN (Bool :test($)!) {
    use Test;
    is contigus-array(1,0), 2;
    is contigus-array(0,1,0), 2;
    is contigus-array(0,0,0,0,0), 0;
    is contigus-array(0,1,0,0,1,0),4;
    done-testing;
}

multi MAIN (+binary) {
    say contigus-array binary
}
