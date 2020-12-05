#!/usr/bin/env perl6
use v6;

my $n=(@*ARGS) ?? (@*ARGS[0].Int) !! (11);
for (1..$n).map({ my $d=($n**2).chars; |(sprintf("%{$d}s",'') xx ($_ - 1)), |($_ X* ($_..$n)).map({ sprintf("%{$d}d", $_) }) }) {.say}

# run as <script> <size of mult. table; defaults to 11>
