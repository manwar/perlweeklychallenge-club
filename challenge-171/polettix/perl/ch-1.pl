#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';
use List::Util 'sum';

my $n = shift // 20;
my @abundants;
my $candidate = 945;
while (@abundants < $n) {
   push @abundants, $candidate if is_abundant($candidate);
   $candidate += 2;
}
say join ', ', @abundants;

sub is_abundant ($n) { $n < sum(proper_positive_divisors($n)) }

sub proper_positive_divisors ($n) {
   return unless $n;
   $n = -$n if $n < 0;
   my (@lows, @highs) = (1);
   my ($lo, $hi) = (2, $n);
   while ($lo < $hi) {
      if ($n % $lo == 0) {
         push @lows, $lo;
         $hi = int($n / $lo);
         unshift @highs, $hi if $hi != $lo;
      }
      ++$lo;
   }
   return (@lows, @highs);
}
