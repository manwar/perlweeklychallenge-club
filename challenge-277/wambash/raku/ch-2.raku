#!/usr/bin/env raku

sub strong-pair (+ints) {
    ints
    andthen .unique
    andthen .combinations: 2
    andthen .grep: -> ($x, $y) { 0 < abs( $x - $y ) < ($x min $y) }\
    andthen .elems
}

multi MAIN (Bool :test($)!) {
    use Test;
    is strong-pair(1..5), 4;
    is strong-pair(5,7,1,7), 1;
    done-testing;
}

multi MAIN (+ints) {
    say strong-pair ints
}
