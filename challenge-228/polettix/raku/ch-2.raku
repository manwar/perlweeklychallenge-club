#!/usr/bin/env raku
use v6;
sub MAIN (*@args) { put empty-array(@args».Int) }

sub empty-array (@ints is copy) {
   my @sorted = @ints.sort;
   my $n = 0;
   while @ints {
      my $item = @ints.shift;
      if $item == @sorted[0] { @sorted.shift     }
      else                   { @ints.push: $item }
      ++$n;
   }
   return $n;
}
