#!/usr/bin/env perl6
use v6;

# run as <script> <quote-enclosed string>

sub encode($str) { (roundrobin (S:g/\s// with $str.lc).comb.rotor(8,:partial)).map(*.join).Str }

say @*ARGS[0].&encode
