#!/usr/bin/env raku

sub is-permuted-multiples ($n) {
    $n X* 1..6
    andthen .map: *.comb
    andthen .map: *.Bag
    andthen [eqv] $_
}

multi MAIN (Bool :test($)!) {
    use Test;
    is is-permuted-multiples( 142857), True;
    is is-permuted-multiples(1428570), True;
    is is-permuted-multiples(1429857), True;
    is is-permuted-multiples(1428957),False;
    is is-permuted-multiples(1423857),False;
    done-testing;
}

multi MAIN ($k=1) {
    ^∞
    andthen .map: { slip 10**$_ .. 10**($_+1)/6 }\
    andthen .hyper
    andthen .grep: &is-permuted-multiples
    andthen .head: $k
    andthen .Supply.tap: &say
}
