#!/usr/bin/env raku
use v6;
sub MAIN (*@inputs) { say left-right-sum-diff(@inputs) }

sub left-right-sum-diff (@inputs) {
   my $sum = 0;
   my @retval;
   for ^@inputs -> $i {
      @retval.push: $sum;
      $sum += @inputs[$i];
   }
   for ^@inputs -> $i {
      $sum -= @inputs[$i];
      @retval[$i] = abs(@retval[$i] - $sum);
   }
   return @retval;
}
