#!/usr/bin/env raku
use v6;
sub MAIN (*@args) { put h-index(@args) }

sub h-index (@citations) {
   @citations = @citations».Int.grep({.so}).sort.reverse;
   $_ < @citations[$_] || return $_ for ^@citations;
   return @citations.elems;
}
