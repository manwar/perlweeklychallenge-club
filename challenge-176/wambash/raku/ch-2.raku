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
    is (10..^ 100).grep( &is-reversible), (
        10, 12, 14, 16, 18, 21, 23, 25, 27,
        30, 32, 34, 36, 41, 43, 45, 50, 52,
        54, 61, 63, 70, 72, 81, 90
    );
    done-testing;
}

multi MAIN (UInt :$min = 10, UInt :$max = 100) {
    $min ..^ $max
    andthen .grep: &is-reversible
    andthen .Supply
    andthen .batch: :16elems
    andthen .tap: &put
}
