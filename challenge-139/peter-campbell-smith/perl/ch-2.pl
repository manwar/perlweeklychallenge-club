#!/usr/bin/perl

# Peter Campbell Smith - 2021-11-15
# PWC 139 task 2

use v5.20;
use warnings;
use strict;

# You are given a list of numbers.
# Write a script to generate first 5 Long Primes
# A prime number (p) is called Long Prime if (1/p) has an infinite decimal expansion repeating every (p-1) digits.
#
# As per Wikipedia, the *shortest* repeating sequence must contain (p-1) digits.

# This script will work with any prime number up to the maximum integer value allowed by hardware and Perl

my (@primes, $prime, $limit, $j, $inverse, $digits, $is_long, $min_repeat, $min_repeat_length, $max_prime);

# make sieve of Eratosthenes to generate primes
$max_prime = 100;
@primes = make_sieve($max_prime);   # primes[j] = 1 if j is prime

# loop over primes
for $prime (2 .. $max_prime) {
	next unless $primes[$prime];
	
	# we need to calculate the inverse to at least (p - 1) * 2 significant digits
	$inverse = precise_inverse($prime);   # inverse as a string preceded by '* ' (to stop Perl making it a float)
	$digits = substr($inverse, 3, $prime - 1);   # first p - 1 digits
	next unless substr($inverse, 2 + $prime, $prime - 1) eq $digits;   # check whether the next (p - 1) digits are the same
	
	$min_repeat = min_repeat($inverse);   # get the smallest group of repeating digits
	$min_repeat_length = length($min_repeat);   # and its length
	next unless $min_repeat_length == $prime - 1;  # and no good unless it is (p - 1) digits long
	
	# format and issue result
	$inverse =~ m|(0\.0*)(.*)|;
	$inverse = $1 . substr($2, 0, 2 * $min_repeat_length);
	say qq[$prime is a long prime since 1/$prime is $inverse\n] .
		qq[The repeating part ($min_repeat) size is ] . $min_repeat_length . 
		qq[ ie 1 less than the prime number $prime\n] if ($min_repeat_length == $prime - 1);
	
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

sub precise_inverse {   # ($value) where $value >= 1
	
	# returns ('* ' . 1/$value), with (2 * $value) digits after the decimal point and following zeroes, as a string
	# using manual long division as taught in primary school
	
	my ($divisor, $remainder, $quotient, $q, %seen); 
	$divisor = $_[0];
	$remainder = 1;
	$quotient = '*0.';

	# one digit at a time
	while (1) {
		$remainder *= 10;
		$q = int($remainder / $divisor);
		$remainder = ($remainder - $q * $divisor);
		$quotient .= $q;
		
		# check that it is at least twice (p - 1) long so that we can check for repeat
		if ($quotient =~ m|\*0\.0*(.*)|) {
			last if length($1) >= 2 * ($divisor - 1);
		}
	}
	return $quotient;
}

sub min_repeat {   # ($value) where $value == '*0.<zero or more zeroes><digits>'

	# returns the length of the shortest repeating string after '*0.<zero or more zeroes>' 
	
	my ($test, $test_length, $j, $snippet, $snippets);
	
	# get the significant digits (ie folowwing '* 0.000...')
	$_[0] =~ m|\*0\.0*(.*)|;
	
	# check to see if the first $j digits repeat to form $test
	$test = $1;
	$test_length = length($test);
	for $j (1 .. int($test_length / 2)) {
		$snippet = substr($test, 0, $j);
		$snippets = $snippet x (int($test_length / length($snippet) + 1));
		$snippets = substr($snippets, 0, $test_length);
		return $snippet if $snippets eq $test;
	}
}
