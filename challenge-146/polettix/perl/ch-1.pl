#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

say prime_at(shift // 10001);

sub prime_at ($n) {
   state $primes  = [ undef, 2, 3 ];
   state $squares = [ undef, 4, 9 ];
   FIND_NEW:
   while ($primes->$#* < $n) {
      my $candidate = $primes->[-1] + 2;
      while ('necessary') {
         for my $i (2 .. $primes->$#*) {
            if ($squares->[$i] > $candidate) {
               push $primes->@*, $candidate;
               push $squares->@*, $candidate * $candidate;
               next FIND_NEW;
            }
            last unless $candidate % $primes->[$i];
         }
         $candidate += 2;
      }
   }
   return $primes->[$n];
}
