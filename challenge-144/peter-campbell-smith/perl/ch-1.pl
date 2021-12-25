#!/usr/bin/perl

# Peter Campbell Smith - 2021-12-20
# PWC 144 task 1

use v5.20;
use warnings;
use strict;

# Write a script to generate all Semiprime number <= 100.
# In mathematics, a semiprime is a natural number that is the product of exactly two 
# prime numbers. The two primes in the product may equal each other, so the semiprimes 
# include the squares of prime numbers.  This definition excludes either of the primes
# being 1.

my ($limit, $sqrt_limit, @is_prime, @semiprimes, $j, $k, $p);

# find semiprimes <= $limit
$limit = 100;

# find primes up to $limit / 2
@is_prime = make_sieve(int($limit / 2));   # $j is prime if $primes[$j] == 1
say qq[Semiprimes no greater than $limit are:];

# the smaller prime cannot exceed sqrt($limit)
for $j (2 .. int(sqrt($limit))) {
	next unless $is_prime[$j];
	
	# the larger one cannot exceed $limit / the smaller one
	for $k ($j .. int($limit / $j)) {
		next unless $is_prime[$k];
		@semiprimes[$j * $k] = 1;
	}
}

for $j (1 .. $limit) {
	print qq[$j ] if (defined $semiprimes[$j]);
}
say '';
		
sub make_sieve {
	
	# make sieve of Eratosthenes
	my ($arg, $j, $k, @sieve);
	
	# set all values provisionally to 1 (ie prime)
	$arg = $_[0];
	for $j (0 .. $arg) {
		$sieve[$j] = 1;
	}
	
	# for each prime in turn, set its multiples to 0 (ie not prime)
	for $j (2 .. $arg) {
		next unless $sieve[$j];   # $j is not prime		
		last if $j ** 2 > $arg;
		for $k ($j .. $arg) {
			last if $k * $j > $arg;
			$sieve[$k * $j] = 0;
		}
	}
	return @sieve;
}