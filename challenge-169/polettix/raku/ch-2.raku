#!/usr/bin/env raku
use v6;
sub MAIN (Int:D $count where * > 0 = 20) {
   my @achilles;
   my $candidate = 72;
   while @achilles < $count {
      @achilles.push: $candidate if is-achilles($candidate);
      ++$candidate;
   }
   put @achilles.join(', ');
}

sub is-achilles ($n) {
   my $gcd;
   for factor_exp($n) -> ($p, $power) {
      return False if $power == 1;
      $gcd = $gcd ?? gcd($gcd, $power) !! $power;
   }
   return $gcd == 1;
}

sub gcd ($A is copy, $B is copy) {
   ($A, $B) = ($B % $A, $A) while $A;
   return $B;
}

sub factor_exp (Int $n) {
   my @retval = [0, 0],;
   for factors($n) -> $p {
      if $p == @retval[*-1][0] { @retval[*-1][1]++ }
      else                     { @retval.push: [$p, 1] }
   }
   @retval.shift;
   return @retval;
}

sub factors (Int $remainder is copy) {
   return 1 if $remainder <= 1;
   state @primes = 2, 3, 5, -> $n is copy {
      repeat { $n += 2 } until $n %% none @primes ... { $_ * $_ >= $n }
      $n;
   } ... *;
   gather for @primes -> $factor {
      if $factor * $factor > $remainder {
         take $remainder if $remainder > 1;
         last;
      }

      # How many times can we divide by this prime?
      while $remainder %% $factor {
         take $factor;
         last if ($remainder div= $factor) === 1;
      }
   }
}
