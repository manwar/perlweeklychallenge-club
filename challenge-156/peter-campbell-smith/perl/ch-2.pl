#!/usr/bin/perl

# Peter Campbell Smith - 2022-03-17
# PWC 156 task 2

# Write a script to find out if a number is a Weird Number, defined as:
# The sum of the proper divisors (divisors including 1 but not itself) of 
# a weird number is greater than the number, but no subset of those divisors 
# sums to the number itself.

# blog: https://pjcs-pwc.blogspot.com/2022/03/pernicious-and-weird.html

use v5.28;

my (@tests, $test, $sum, @divisors, $divisor, $num_subsets, $bit, $j, $bad, $num_divisors);

@tests = (12 .. 70, 836);

for $test (@tests) {
	
	$sum = 0;
	@divisors = ();
	$bad = '1 - good';
	
	# find the proper divisors and their sum
	$j = 0;
	for $divisor (1 .. $test / 2) {
		next unless $test / $divisor == int($test / $divisor);
		$divisors[$j ++] = $divisor;
		$sum += $divisor;
	}
	
	# first test - does sum of divisors exceed given number?
	if ($sum <= $test) {
		$bad = qq[0 - divisor sum ($sum) too small];
	
	# second test - does any subset of divisors sum to the given number?
	} else {
			
		# loop over subsets of divisors: there are 2 ** (number of divisors) subsets
		# and we can loop over them by treating 1 .. (number of subsets - 1) as a binary 
		# mask to determine which divisors we sum
		
		$num_divisors = scalar @divisors;
		$num_subsets = 2 ** $num_divisors;
		for ($j = $num_subsets - 1; $j >= 0; $j --) {
					
			# make a sum of one subset of divisors
			$sum = 0;
			$bit = $num_divisors - 1;
			for $b (0 .. $bit) {
				$sum += $divisors[$bit] if $j & (2 ** $bit);
				last if $sum > $test;
				$bit --;
			}
			
			# no good
			if ($sum == $test) {
				$bad = '0 - divisor sum matches number';
				last;
			}
		}
	}	
	say qq[\nInput:  $test\nOutput: $bad];
}

