#!/usr/bin/env raku
use v6;

class PerrinSequence {
   has @!state = [3, 0, 2];
   method get () {
      @!state.push(@!state[0] + @!state[1]);
      return @!state.shift;
   }
}

multi sub MAIN (1) { put 2 }

multi sub MAIN (2) { put '2, 3' }

multi sub MAIN (3) { put '2, 3, 5' }

multi sub MAIN (Int:D $n is copy where * > 3 = 13) {
   my $ps = PerrinSequence.new;
   $ps.get for 1..7;
   my @n-primes = gather while $n > 3 {
      my $candidate = $ps.get;
      next unless $candidate.is-prime;
      take $candidate;
      --$n;
   }
   [2, 3, 5, |@n-primes].join(', ').put;
}
