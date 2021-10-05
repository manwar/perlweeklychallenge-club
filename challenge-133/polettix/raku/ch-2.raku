#!/usr/bin/env raku
use v6;
sub is-smith (Int:D() $x is copy where * > 0) {
   my $sum = $x.comb(/\d/).sum;
   my $div = 2;
   my $ndiv = 0;
   while $x > 1 && $sum > -1 {
      if $x %% $div {
         my $subsum = $div.comb(/\d/).sum;
         while $x %% $div {
            $sum -= $subsum;
            $x /= $div;
            ++$ndiv;
         }
      }
      $div += $div == 2 ?? 1 !! 2;
   }
   return $sum == 0 && $ndiv > 1;
}
sub smith-first (Int:D $n is copy where * > 0) {
   my $candidate = 3; # one less of first composite number
   gather while $n > 0 {
      next unless is-smith(++$candidate);
      take $candidate;
      --$n;
   }
}
sub MAIN ($n = 10) { .put for smith-first($n) }
