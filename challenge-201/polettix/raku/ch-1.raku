#!/usr/bin/env raku
use v6;
sub MAIN (*@args) { .put for missing-numbers(@args) }

sub missing-numbers (@array) {
   my $present = @array».Str.Set;
   return [(0 .. @array.elems).grep({ $_.Str ∉ $present })];
}
