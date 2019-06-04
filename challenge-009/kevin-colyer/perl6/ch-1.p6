#!/usr/bin/env perl6
use v6;

say "Part 1 (first square number with 5 distinct digits)";
for (100..10_000) -> $i { my $j=$i**2; "$i -> $j".say && last if $j.comb.unique.elems==5 };
