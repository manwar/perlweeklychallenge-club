#!/usr/bin/env raku

sub nearest-valid-point (+points,:$x,:$y) {
    points
    andthen .grep: { $x == .[0] or $y == .[1] },:p
    andthen .min: {abs(.value[0]-$x)+ abs(.value[1]-$y)}\
    andthen $_ eqv ∞ ?? -1 !! .key
}

multi MAIN (Bool :test($)!) {
    use Test;
    is nearest-valid-point([1, 2], [3, 1], [2, 4], [2, 3]):3x:4y, 2;
    is nearest-valid-point([3, 4], [2, 3], [1, 5], [2, 5]):2x:5y, 3;
    is nearest-valid-point([2, 2], [3, 3], [4, 4]):1x:1y, -1;
    is nearest-valid-point([0, 1], [1, 0], [0, 2], [2, 0]):0x:0y, 0;
    is nearest-valid-point([5, 6], [6, 5], [5, 4], [4, 5]):5x:5y, 0;
    done-testing;
}

multi MAIN (+points,:$x,:$y) {
    say nearest-valid-point points».comb(/\d+/),:$x,:$y;
}
