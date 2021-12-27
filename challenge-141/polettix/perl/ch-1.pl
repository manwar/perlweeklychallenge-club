#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

sub count_divisors ($n) {
   my $c = 2; # 1, $n
   for my $d (2 .. $n / 2) {
      ++$c unless $n % $d;
   }
   return $c;
}

sub number_divisors ($n) {
   my $i = 1;
   my @retval;
   while ($n > 0) {
      if (count_divisors($i) == 8) {
         push @retval, $i;
         --$n;
      }
      ++$i;
   }
   return @retval;
}

say for number_divisors(shift // 10);
