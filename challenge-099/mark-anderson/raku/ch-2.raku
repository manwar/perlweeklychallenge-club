#!/usr/bin/env raku
use Test;
plan 2;

is unique-subsequence("littleit", "lit"), 5;
is unique-subsequence("london",   "lon"), 3;

sub unique-subsequence($S, $T) 
{
    +($S ~~ m:ex/<{ $T.comb.join(" .* ") }>/);
}
