#!/usr/bin/env raku
use v6;
sub MAIN ($bits) { put special-bits-characters($bits.comb.Array) }

sub special-bits-characters ($bits) {
   $bits.join('') ~~ m{^ [ 1 <[ 0 1 ]> | 0 ]* 0 $} ?? 1 !! 0;
}
