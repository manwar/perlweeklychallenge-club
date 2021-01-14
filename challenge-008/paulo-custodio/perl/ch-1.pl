#!/usr/bin/env perl

# Challenge 008
#
# Challenge #1
# Write a script that computes the first five perfect numbers. A perfect number
# is an integer that is the sum of its positive proper divisors (all divisors
# except itself). Please check Wiki for more information. This challenge was
# proposed by Laurent Rosenfeld.

use strict;
use warnings;
use 5.030;
use Math::Prime::Util 'next_prime', 'is_prime';

# Euclid proved that 2^(p−1)*(2^p − 1) is an even perfect number 
# whenever 2p − 1 is prime 
sub perfect_iter {
	my $p = 1;
	return sub {
		while (1) {
			$p = next_prime($p); 	# next prime number
			my $f = (2**$p)-1;
			return (2**($p-1))*$f if is_prime($f);
		}
	};
}


my $n = shift || 5;
my $iter = perfect_iter();
for (1..$n) {
	say $iter->();
}
