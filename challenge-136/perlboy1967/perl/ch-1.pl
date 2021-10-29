#!/usr/bin/perl

=pod

Perl Weekly Challenge - 136
 - https://perlweeklychallenge.org/blog/perl-weekly-challenge-136/#TASK1

Author: Niels 'PerlBoy' van Dijke

TASK #1 › Two Friendly
Submitted by: Mohammad S Anwar

You are given 2 positive numbers, $m and $n.

Write a script to find out if the given two numbers are Two Friendly.

 ||   Two positive numbers, m and n are two friendly when gcd(m, n) = 2 ^ p where p > 0. 
 ||   The greatest common divisor (gcd) of a set of numbers is the largest positive number 
 ||   that divides all the numbers in the set without remainder.

=cut

use v5.16;
use strict;
use warnings;

# Prototype
sub gcd($$);

# Unbuffered STDOUT
$|++;

use Scalar::Util qw(looks_like_number);

my ($M, $N) = @ARGV;

die "Please provide two positive integer numbers"
  unless (looks_like_number($M) and $M > 0 and $M == int($M) and
          looks_like_number($N) and $N > 0 and $N == int($N));

my $gcd = gcd($M,$N); 
my $exponent = log($gcd)/log(2);
my $isTwoFriendly = (int($exponent) == $exponent) && ($exponent > 0);

printf "Input: m = %d, n = %d\n", $M, $N;
printf "Output: %d\n", $isTwoFriendly;
printf "Reason: gcd(%d,%d) = %d %s\n", $M, $N, $gcd, 
        ($isTwoFriendly ? sprintf(' => 2 ^ %d', $exponent) : '');


sub gcd ($$) {
  return 0 == $_[1] ? $_[0] : gcd($_[1], $_[0] % $_[1]);
} 
