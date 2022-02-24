#!/usr/bin/env raku
use v6;
sub MAIN (Int:D $n = 145) { put is-factorion($n) ?? 1 !! 0 }

sub is-factorion (Int:D $n where $n >= 0) {
   state %factorions = set(1, 2, 145, 40585);
   return $n ∈ %factorions;
}
