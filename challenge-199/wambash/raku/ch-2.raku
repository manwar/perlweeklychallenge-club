#!/usr/bin/env raku
use v6.e.PREVIEW;

sub good-triplet (+@ ($a,$b,$c),:$x!,:$y!,:$z!) {
    True
    && -$x ≤ $a - $b ≤ $x
    && -$y ≤ $b - $c ≤ $y
    && -$z ≤ $c - $a ≤ $z
    andthen .so
}

sub good-triplets (+@list, :$x,:$y,:$z) {
    @list
    andthen .combinations(3)
    andthen .grep: &good-triplet.assuming: :$x:$y:$z
    andthen .elems
}

multi MAIN (Bool :test($)!) {
    use Test;
    is good-triplet(3,0,1,   :7x:2y:3z),  True;
    is good-triplets(3,0,1,1,9,7,:7x:2y:3z), 4;
    is good-triplets(1,1,2,2,3, :0x:0y:1z),  0;
    done-testing;
}

multi MAIN (*@list, :$x,:$y,:$z) {
    say good-triplets @list, :$x,:$y,:$z
}
