#!/usr/bin/perl

# Challenge 012
#
# Challenge #1
# The numbers formed by adding one to the products of the smallest primes are
# called the Euclid Numbers (see wiki). Write a script that finds the smallest
# Euclid Number that is not prime. This challenge was proposed by 
# Laurent Rosenfeld.

use strict;
use warnings;
use 5.030;
use Math::Prime::Util 'next_prime', 'is_prime';

sub euclid_iter {
	my $prime = 1;
	my $prime_prod = 1;
	return sub {
		$prime = next_prime($prime);
		$prime_prod *= $prime;
		return $prime_prod+1;
	};
}

my $iter = euclid_iter();
my $p;
1 while (is_prime($p = $iter->()));
say $p;

