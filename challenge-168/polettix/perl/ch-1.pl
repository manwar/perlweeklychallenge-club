#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

use ntheory 'is_prime';

my $n = shift // 13;
say join ', ', perrin_primes($n);

sub perrin_primes ($n) {
   my @pps = (2, 3, 5);
   my @state = (2, 5, 5);
   while (@pps < $n) {
      push @state, my $candidate = $state[0] + $state[1];
      shift @state;
      push @pps, $candidate if is_prime($candidate);
   }
   return @pps;
}
