#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';
use List::Util 'sum';
sub is_smith ($x) {
   my $sum = sum split m{}mxs, $x;
   my $div = 2;
   my $ndiv = 0;
   while ($x > 1 && $sum > -1) {
      if ($x % $div == 0) {
         my $subsum = sum split m{}mxs, $div;
         while ($x % $div == 0) {
            $sum -= $subsum;
            $x /= $div;
            ++$ndiv;
         }
      }
      $div = $div % 2 ? $div + 2 : 3;
   }
   return $sum == 0 && $ndiv > 1;
}
sub smith_first ($n) {
   my @retval;
   my $candidate = 3; # one less of first composite number
   while ($n > @retval) {
      next unless is_smith(++$candidate);
      push @retval, $candidate;
   }
   return @retval;
}
say for smith_first(shift // 10);
