#!/usr/bin/perl

# Peter Campbell Smith - 2021-10-05
# PWC 133 task 2

use strict;
use warnings;

# Find the first 10 Smith numbers.

# A Smith number is not prime and the sum of its digits equals the sum of
# the digits of its prime factors.

my ($j, $sd_of_number, @prime_factors, $k, $sd_of_prime_factors, $count, @sieve);

# make sieve of Eratosthenes
@sieve = make_sieve(1000);     # $sieve[$j] == 1 if $j is prime or == 0 if not

# main loop
$count = 1;
for $j (2 .. 10000) {
	next if $sieve[$j];   # not a candidate as $j is prime
	
	$sd_of_number = sum_of_digits($j);
	
	$sd_of_prime_factors = 0;
	@prime_factors = prime_factors($j);
	for $k (@prime_factors) {
		$sd_of_prime_factors += sum_of_digits($k);
	}		
	next unless $sd_of_number == $sd_of_prime_factors;
	
	print qq[Smith number $count is $j\n];
	last if $count ++ == 10;
}

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

sub sum_of_digits {
	
	# returns sum of the digits of the argument
	my ($number, $digit, $sum);
	
	$number = $_[0];
	while ($number) {
		$digit = $number % 10;
		$sum += $digit;
		$number = ($number - $digit) / 10;
	}
	return $sum;
}

sub prime_factors {

	# return array of prime factors of argument
	my ($j, $arg, $rem, @factors);

	$arg = $_[0];
	$rem = $arg;
	for $j (2 .. $arg) {
		next unless $sieve[$j];
		while ($rem % $j == 0) {
			push @factors, $j;
			$rem /= $j;
		}
	}
	return @factors;	
}
	

