#!/usr/bin/env raku
use v6;
sub MAIN (*@args) { put unique-sum(@args) }

sub unique-sum (@ints) {
   my $retval = 0;
   my $seen = BagHash.new;
   for @ints -> $x {
      given $seen{$x}++ {
         $retval += $x when 0;
         $retval -= $x when 1;
      }
   }
   return $retval;
}
