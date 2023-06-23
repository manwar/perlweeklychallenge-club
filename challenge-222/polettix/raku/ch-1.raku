#!/usr/bin/env raku
use v6;
sub MAIN (*@list) { put matching-members(@list) }

sub matching-members (Positional(Int()) $list) {
   return ($list «==» $list.sort).sum;
   # OR: ($list «==» $list.sort).grep({$_}).elems;
}
