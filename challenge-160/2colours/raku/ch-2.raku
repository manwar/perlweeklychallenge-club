#!/usr/bin/env raku

my @n = prompt('Input: @n = ').comb(/\d+/)>>.Int;
my $equilibrium-index is default(-1) = (^@n).first({ @n[^$_].sum == @n[$_^..*].sum });
say "Output: $equilibrium-index";