#!/usr/bin/perl

# Peter Campbell Smith - 2022-01-10
# PWC 147 task 1

use v5.28;
use warnings;
use strict;

# Write a script to generate first 20 left-truncatable prime numbers in base 10.
# In number theory, a left-truncatable prime is a prime number which, in a given base, 
# contains no 0, and if the leading left digit is successively removed, then all 
# resulting numbers are primes.

# Note that the last digit cannot be 2, 4, 5, 6, 8, 0 as no primes end with those
# and cannot be 9 as when all the preceding digits are removed, 9 is not prime,
# so the last digit can only be 1, 3 or 7.

# The definition above speaks of 'all resulting numbers' so I am ruling out
# single-digit prime numbers as they have no 'resulting numbers' when the
# leftmost digit is removed.

my ($seeking, $prime_index, $from, $to, $test, $this, @not_a_prime, $string, $count,
	$start, $factor, $multiple, $secs);

# initialise
$seeking = 20;   # how many to find
$count = 0;      # how many found

# find primes in ranges of 1000
$secs = time;
for ($from = 1; ; $from += 1000) {
	$to = $from + 999;

	# loop over all the possible factors, ie primes < sqrt($to)
	for $factor (2 .. int(sqrt($to))) {
		next if defined $not_a_prime[$factor];   # already known as not a prime
		
		# mark all the multiples of $factor as non-primes (sieve of Eratosthenes)
		$start = int($from / $factor);           # multiples less than $start have already been done
		$start = 2 if $start < 2;
		for ($multiple = $start; $factor * $multiple <= $to; $multiple ++) {
			$not_a_prime[$factor * $multiple] = 1;
		}
	}
	
	# now test the primes in this range for left-truncatability
	TEST: for $test ($from .. $to) {
		
		# remove ineligibles - not prime, is a single digit, contains 0 or ends in 9
		next if (defined $not_a_prime[$test] or $test =~ m|0| or $test =~ m|9$| or $test < 11);
			
		# test for left-truncatability and construct string showing proof
		$this = $test;
		$string = qq[$this];
		
		# remove successive left digits and test the residue for primeness
		while ($this =~ s|\d(\d+)|$1|) {   
			next TEST if $not_a_prime[$this];
			$string .= qq[ > $this];			
		}
		
		# an answer!
		say $string;
		if (++ $count >= $seeking) {
			say '' . (time - $secs) . qq[ seconds\n];
			exit;
		}
	}
}
