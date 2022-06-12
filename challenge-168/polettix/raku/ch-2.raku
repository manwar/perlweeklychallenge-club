#!/usr/bin/env raku
use v6;
sub MAIN (Int:D $n where * > 1 = 10) { put home-prime($n) }

sub home-prime ($n is copy) {
   loop {
      my $m = factors($n).join('').Int;
      return $n if $n == $m;
      $n = $m;
   }
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
