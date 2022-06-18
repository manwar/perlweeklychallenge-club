#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

use ntheory qw< factor_exp >;

my $count = shift // 20;
my @achilles;
my $candidate = 72;
while (@achilles < $count) {
   push @achilles, $candidate if is_achilles($candidate);
   ++$candidate;
}
say join ', ', @achilles;

sub is_achilles ($n) {
   my $gcd;
   for my $pair (factor_exp($n)) {
      my $power = $pair->[1];
      return 0 if $power == 1;
      $gcd = $gcd ? gcd($gcd, $power) : $power;
   }
   return $gcd == 1;
}

sub gcd ($A, $B) { ($A, $B) = ($B % $A, $A) while $A; return $B }
