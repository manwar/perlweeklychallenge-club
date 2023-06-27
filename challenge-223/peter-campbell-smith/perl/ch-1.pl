#!/usr/bin/perl

use v5.16;    # The Weekly Challenge - 2023-06-26
use utf8;     # Week 222 task 1 - Count primes
use strict;   # Peter Campbell Smith
use warnings; # Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

count_primes(10);
count_primes(1);
count_primes(20);
count_primes(17);
count_primes(1000000);

sub count_primes {
	
	my ($number, @sieve, $j, $count);
	
	$number = shift @_;
	
	# count primes
	if ($number > 1) {
		@sieve = make_sieve($number);
		for $j (2 .. $number) {
			$count += $sieve[$j];
		}
		
	# $number is 0 or 1
	} else {
		$count = 0;
	}
	
	say qq[\nInput:  \$n = $number\nOutput: $count];
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
