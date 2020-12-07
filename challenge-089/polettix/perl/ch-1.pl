#!/usr/bin/env perl
use 5.024;
use warnings;
use experimental qw< postderef signatures >;
no warnings qw< experimental::postderef experimental::signatures >;

sub gcd { my ($A, $B) = @_; ($A, $B) = ($B % $A, $A) while $A; return $B }

sub GCD_sum ($N) {
   my $sum = $N - 1; # gcd(1, $x) = 1
   for my $lo (2 .. $N - 1) {
      $sum += gcd($lo, $_) for $lo + 1 .. $N;
   }
   return $sum;
}

say GCD_sum(shift || 4);
