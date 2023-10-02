#!/usr/bin/env raku
use v6;
sub MAIN ($s, $t) { put(([(-)] ($t, $s)».comb».Bag).elems == 0) }
