#!/usr/bin/env perl6
use v6;

sub minpr(Int $n where * >= 2) {
    ($n.is-prime) && return 1;
    return 1+(2 ...^ *>$n)
    .grep(*.is-prime)
    .map({ $n-$_ })
    .grep(* >= 2)
    .map(&minpr)
    .min;
}

say minpr(@*ARGS.[0].Int);

# run as <script> <number>
