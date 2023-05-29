#!/usr/bin/env raku
use v6;
sub MAIN (*@args) { say maximum-product(@args) }

sub maximum-product (@args) {
   my @sorted = @args».Int.sort;
   my $below = @sorted[0] * @sorted[1] * @sorted[* - 1];
   my $above = [*] @sorted.reverse[0..2];
   return ($below, $above).max;
}
