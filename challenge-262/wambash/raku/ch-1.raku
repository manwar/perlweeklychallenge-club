#!/usr/bin/env raku

sub max-positive-negative (+ints) {
    ints
    andthen .classify: *.sign
    andthen .nodemap: *.elems
    andthen .{-1,1}.max
}

multi MAIN (Bool :test($)!) {
    use Test;
    is max-positive-negative(-3,1,2,-1,3,-2,4),4;
    is max-positive-negative(-1, -2, -3, 1),   3;
    is max-positive-negative(1,2),             2;
    done-testing;
}

multi MAIN (+ints) {
    say max-positive-negative ints
}
