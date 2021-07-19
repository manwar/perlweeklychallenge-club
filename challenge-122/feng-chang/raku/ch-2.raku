#!/bin/env raku

sub score(UInt:D $N, Array:D $s) {
    put $s if $N == 0;
    score($N - 1, [|$s, 1]) if $N ≥ 1;
    score($N - 2, [|$s, 2]) if $N ≥ 2;
    score($N - 3, [|$s, 3]) if $N ≥ 3;
}

sub MAIN(UInt:D $N) { score($N, []) }
