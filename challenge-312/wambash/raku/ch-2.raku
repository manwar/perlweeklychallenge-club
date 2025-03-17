#!/usr/bin/env raku

sub balls-and-boxes ($str) {
    $str
    andthen .comb
    andthen .map: -> $v, $k { $k => $v }\
    andthen .classify: *.key, :as(*.value)
    andthen .values
    andthen .grep: {<R G B>.all ∈ $_ }\
    andthen .elems
}

multi MAIN (Bool :test($)!) {
    use Test;
    is balls-and-boxes('G0B1R2R0B0'),1;
    is balls-and-boxes('G1R3R6B3G6B1B6R1G3'),3;
    is balls-and-boxes('B3B2G1B3'),0;
    done-testing;
}

multi MAIN ($str) {
    say balls-and-boxes $str
}
