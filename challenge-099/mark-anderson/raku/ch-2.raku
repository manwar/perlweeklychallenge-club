#!/usr/bin/env raku
use Test;
plan 2;

is unique-subsequences("littleit", "lit"), 5;
is unique-subsequences("london",   "lon"), 3;

sub unique-subsequences($S, $T) 
{
    +($S ~~ m:ex/ <{ $T.comb.join(" .* ") }> /);
}
