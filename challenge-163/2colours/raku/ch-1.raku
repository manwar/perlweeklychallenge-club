#!/usr/bin/env raku

my @n = prompt('Input: @n = ') ~~ m:g/\d+/;
say "Output: {@n.combinations(2).map({ [+&] $_ }).sum}"; 