#!/usr/bin/env raku

sub is-reversible (UInt $n --> Bool) {
    $n + $n.flip
    andthen .comb
    andthen so .none %% 2
}

multi MAIN (Bool :test($)!) {
    use Test;
    is is-reversible(    14), True;
    is is-reversible(   144),False;
    is is-reversible(   748), True;
    is is-reversible(123456), True;
    is is-reversible( 12345),False;
    done-testing;
}

multi MAIN (:$min = 10, :$max = 100) {
    $min ..^ $max
    andthen .grep: &is-reversible
    andthen .Supply
    andthen .batch: :16elems
    andthen .tap: &put
}
