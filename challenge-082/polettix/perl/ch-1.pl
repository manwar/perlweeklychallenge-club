#!/usr/bin/env perl
use 5.024;
use warnings;
use English qw< -no_match_vars >;
use experimental qw< postderef signatures >;
no warnings qw< experimental::postderef experimental::signatures >;

sub gcd ($A, $B) { ($A, $B) = ($B % $A, $A) while $A; return $B }

sub common_factors ($A, $B) {
   my $gcd = gcd($A, $B);
   grep { !($gcd % $_) } 1 .. int($gcd / 2), $gcd;
}

my $M = shift || 12;
my $N = shift || 18;
say '(', join(', ', common_factors($M, $N)), ')';
