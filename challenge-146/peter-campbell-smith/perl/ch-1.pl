#!/usr/bin/perl

# Peter Campbell Smith - 2022-01-04
# PWC 146 task 1

use v5.28;
use warnings;
use strict;

# Write a script to generate the 10001st prime number.
	
# The sieve of Eratosthenes is a quick way to generate all the primes up to
# some maximum number.  However, that's not today's question.  This script
# therefore generates the sieve in 1000 blocks (ie 1-1000, then 1001 to 2000 
# and so on), counting the number of primes found in each block and stopping
# when that reaches or exceeds 10001.

# It takes less than 1 second to run on my machine. And to find the 1000001st
# prime takes only 28 seconds.  I haven't found a faster method.

my ($seeking, $prime_index, $from, $to, $test, $factor, $multiple, @not_a_prime,
	@prime, $time, $start);

# initialise
$seeking = 10001;
$time = time;
$prime_index = 0;

# find primes in ranges of 1000, and count them until we get to (or past) $seeking
for ($from = 1; $prime_index <= $seeking; $from += 1000) {
	$to = $from + 999;

	# loop over all the possible factors, ie primes < sqrt($to)
	for $factor (2 .. int(sqrt($to))) {
		next if defined $not_a_prime[$factor];   # already known as not a prime
		
		# mark all the multiples of $factor as non-primes
		$start = int($from / $factor);           # multiples less than $start have already been done
		$start = 2 if $start < 2;
		for ($multiple = $start; $factor * $multiple <= $to; $multiple ++) {
			$not_a_prime[$factor * $multiple] = 1;
		}
	}
	
	# now enumerate the primes in this range
	for $test ($from .. $to) {
		next if $test == 1;                       # 1 is not regarded as a prime
		if (not defined $not_a_prime[$test]) {    # $test is a new prime
			$prime[++ $prime_index] = $test;
		}
	}
}

say qq[Prime no $seeking is $prime[$seeking]\nFound in ] . (time - $time) . qq[ seconds];
say qq[This assumes that that first prime is 2, as per Wikipedia. If you reckon that
the first prime is 1 then prime number $seeking is $prime[$seeking - 1]];
