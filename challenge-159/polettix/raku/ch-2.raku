#!/usr/bin/env raku
use v6;
multi sub MAIN (*@args) { put $_, ' ', möbius-number($_) for @args}

sub möbius-number ($n is copy) {
   return 0 if $n %% 4;
   ($n, my $n-divisors) = $n %% 2 ?? (($n / 2).Int, 1) !! ($n, 0);
   my $divisor = 3;
   while $n >= $divisor {
      if $n %% $divisor {
         ++$n-divisors;
         $n = ($n / $divisor).Int;
         return 0 if $n %% $divisor;
      }
      $divisor += 2; # go through odd candidates only
   }
   return 1 - 2 * ($n-divisors % 2);
}
