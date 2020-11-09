#!/usr/bin/env perl6
use v6;

sub bits($n) {
    (1..$n).map(*.base(2)).join.indices(1).elems % 1000000007
}

say bits(@*ARGS[0]);

# run as <script> number
