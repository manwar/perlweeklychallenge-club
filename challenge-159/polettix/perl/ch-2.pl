#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

say $_, ' ', moebius_number($_) for (@ARGV ? @ARGV : (1 .. 10));

sub moebius_number ($n) {
   return 0 unless $n % 4;
   ($n, my $n_divisors) = $n % 2 ? ($n, 0) : ($n / 2, 1);
   my $divisor = 3;
   while ($n >= $divisor) {
      if ($n % $divisor == 0) {
         ++$n_divisors;
         $n /= $divisor;
         return 0 unless $n % $divisor;
      }
      $divisor += 2; # go through odd candidates only
   }
   return 1 - 2 * ($n_divisors % 2);
}

