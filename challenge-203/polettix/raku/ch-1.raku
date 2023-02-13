#!/usr/bin/env raku
use v6;
sub MAIN (*@args) { put special-quadruplets(@args) }

sub special-quadruplets (@nums) {
   combinations(@nums, 4).grep({$_[0..2].sum == $_[3]}).elems
}
