#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

use FindBin '$Bin';
use lib "$Bin/local/lib/perl5";
use ntheory qw< is_prime next_prime >;
use List::MoreUtils 'uniq';
use bigint;

say join ', ', first_fortunate_numbers(shift || 8);

sub first_fortunate_numbers ($n) {
   my $it = fortunate_numbers_it();
   my (@cleared, @seen);
   while (@cleared < $n) {
      my ($prime, $fn) = $it->();
      @seen = uniq sort { $a <=> $b } (@seen, $fn);
      push @cleared, shift @seen while @seen && $seen[0] < $prime;
   }
   return @cleared[0 .. $n - 1];
}

sub fortunate_numbers_it {
   my $primorial = 1;
   my $prime = 1; # bear with me please...
   return sub {
      $prime = next_prime($prime);
      $primorial *= $prime;
      return (2, 3) if $prime == 2;
      my $n = $prime;
      while ('necessary') {
         $n += 2;
         return ($prime, $n) if is_prime($primorial + $n);
      }
   };
}
