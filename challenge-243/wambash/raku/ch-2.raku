#!/usr/bin/env raku

sub floor-sum (+nums) {
    [X,] nums xx 2
    andthen .map: -> ($x,$y) {$y div $x}\
    andthen .sum
}

multi MAIN (Bool :test($)!) {
    use Test;
    is floor-sum(2,5,9),10;
    is floor-sum(7 xx 7), 49;
    done-testing;
}

multi MAIN (+nums) {
    say floor-sum nums
}
