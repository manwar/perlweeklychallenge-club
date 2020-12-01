#!/usr/bin/env perl6
use v6;

sub digsum($n,$s) {
    ((10 ** ($n-1))..^(10 ** $n)).grep({ $_.comb.sum == $s })
}

say digsum(@*ARGS[0], @*ARGS[1])

# run as <script> <nr of digits> <digit sum>

