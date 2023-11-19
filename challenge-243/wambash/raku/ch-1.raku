#!/usr/bin/env raku

sub reverse-pairs (+nums) {
    nums
    andthen .combinations: 2
    andthen .grep: -> ($x, $y) { $x > 2 * $y }, :p
    andthen .elems
}

multi MAIN (Bool :test($)!) {
    use Test;
    is reverse-pairs(1,3,2,3,1),2;
    is reverse-pairs(2, 4, 3, 5, 1), 3;
    done-testing;
}

multi MAIN (+nums) {
    say reverse-pairs nums
}
