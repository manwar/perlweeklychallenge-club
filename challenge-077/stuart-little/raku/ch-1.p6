#!/usr/bin/env perl6
use v6;

sub fibsum($n) {
    (1,2,* + * ... * >= $n)
    .combinations
    .grep(*.sum == $n)
}

for (fibsum(@*ARGS.[0].Int)) { .say }

# run as <script> <number>
