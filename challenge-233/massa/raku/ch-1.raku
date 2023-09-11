#!/usr/bin/env raku

use v6.d;
use Test;

plan 3;

is 2, similar-words <aba aabb abcd bac aabc>;
is 3, similar-words <aabb ab ba>;
is 0, similar-words <nba cba dba>;

sub similar-words(@_) { 
  @_.combinations(2).grep(-> ($a, $b) { $a.comb.Set eqv $b.comb.Set }).elems
}