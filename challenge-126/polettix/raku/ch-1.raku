#!/usr/bin/env raku
use v6;

sub count-like-no-one-bf (Int:D $N where * > 0) {
   (2 .. $N).grep({! /1/}).elems
}

sub count-like-no-one (Int:D $N where * > 0) {
   my $count = 0;
   my @digits = $N.comb;
   while (@digits) {
      my $first = @digits.shift;
      if (@digits) {
         my $factor = $first > 1 ?? $first - 1 !! $first;
         $count += $factor * 9 ** @digits;
      }
      else {
         $count += $first > 1 ?? $first !! 1;
      }
      last if $first == 1;
   }
   return $count - 1;
}

sub MAIN (Int:D $N where * > 0) {
   say count-like-no-one($N) - count-like-no-one-bf($N);
}
