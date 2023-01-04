#!/usr/bin/perl

# Peter Campbell Smith - 2023-02-03
# PWC 198 task 2

use v5.28;
use utf8;
use warnings;

# Write a script to print the count of primes less than a given $n.

# Blog: https://pjcs-pwc.blogspot.com/2023/01/mind-gap.html

my (@tests, $test, @sieve, $output, $j);
@tests = (10, 15, 1, 25, 17, 2, 1000, 1000000);

# loop over tests
for $test (@tests) {
	
	# make sieve of Eratosthenes
	@sieve = make_sieve($test - 1);
	
	# count primes
	$output = 0;
	for $j (2 .. $test - 1) {
		$output ++ if $sieve[$j];
	}
	say qq[\nInput:  $test\nOutput: $output];
}

sub make_sieve {
	
	# make sieve of Eratosthenes : $sieve[$j] = is_prime($j) ? 1 : 0;
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