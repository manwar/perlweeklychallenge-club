#!/usr/bin/env perl

# Challenge 085
#
# TASK #2 › Power of Two Integers
# Submitted by: Mohammad S Anwar
# You are given a positive integer $N.
# 
# Write a script to find if it can be expressed as a ** b where a > 0 and b > 1. Print 1 if you succeed otherwise 0.
# 
# Example 1:
# Input: 8
# Output: 1 as 8 = 2 ** 3
# Example 2:
# Input: 15
# Output: 0
# Example 3:
# Input: 125
# Output: 1 as 125 = 5 ** 3

use strict;
use warnings;
use 5.030;

# Sieve of Eratosthenes
my @sieve;
my @primes;

my($n) = @ARGV;
say is_perfect_power($n);


sub is_perfect_power {
	my($n) = @_;
	my $max_factor = sqrt($n)+1;
	find_primes($max_factor);		# fill list of prime numbers up to sqrt(n)+1
	for my $prime (@primes) {
		my $exp = 1;
		my $power;
		while (($power = $prime ** $exp) <= $n) {
			if ($power == $n) {
				return 1;
			}
			$exp++;
		}
	}
	return 0;
}

sub find_primes {
	my($max) = @_;
	my $prime = 2;
	do {
		push @primes, $prime;
		for (my $f = $prime*2; $f < $max; $f += $prime) {
			$sieve[$f] = 1;
		}
		do {
			$prime++
		} while ($prime < $max && $sieve[$prime]);
	} while ($prime < $max);
}
