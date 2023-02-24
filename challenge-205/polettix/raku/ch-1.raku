#!/usr/bin/env raku
use v6;
sub MAIN (*@args) { put third-highest(@args) }

sub third-highest (@array) {
   my @highest;
   ITEM:
   for @array -> $x is copy {
      for ^@highest -> $i {
         next ITEM if $x == @highest[$i];
         ($x, @highest[$i]) = @highest[$i], $x if $x > @highest[$i];
      }
      @highest.push: $x if @highest < 3;
   }
   return @highest == 3 ?? @highest[2]
        !! @highest > 0 ?? @highest[0]
        !!                 Nil;
}
