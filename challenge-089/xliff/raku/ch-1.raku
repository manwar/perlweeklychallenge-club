#!/usr/bin/env raku
# Task 1

my $n = prompt "Input: ";

my $o = (1...$n).combinations(2).map({ .[0] gcd .[1] }).sum;
say "Output: $o\n\n";
