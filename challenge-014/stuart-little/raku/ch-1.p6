#!/usr/bin/env perl6
use v6;

say (0, sub (*@a) { my $ix = @a[0..*-2].reverse.first(@a[*-1], :k); ($ix ~~ Int) ?? $ix+1 !! 0 } ... *).[0..^((@*ARGS) ?? @*ARGS[0].Int !! 50)]

# run as <script> <no. of terms you want to see; defaults to 50>
