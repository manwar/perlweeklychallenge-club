#!/usr/bin/env perl6
use v6;

sub slide($w, @a where @a >= $w) {
    (0..@a-$w).map({ @a.[$_..^$_+$w].min })
}

say slide(@*ARGS[0].Int, @*ARGS[1..*].map(*.Int));

# run as <script> <window size> <space-separated array entries>
