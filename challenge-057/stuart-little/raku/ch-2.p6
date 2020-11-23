#!/usr/bin/env perl6
use v6;

sub uprefix($w,@a) {
    ([\~] $w.comb).first(-> $p { @a.grep({ $_.starts-with($p) }).elems == 1 })
}

say @*ARGS.map({ uprefix($_,@*ARGS) })

# run as <script> <space-separated words>
