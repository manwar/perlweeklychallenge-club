#!/usr/bin/perl

# Peter Campbell Smith - 2021-12-20
# PWC 144 task 2

use v5.20;
use warnings;
use strict;

# You are given two positive numbers, $u and $v.
# Write a script to generate Ulam Sequence having at least 10 Ulam numbers where $u and $v are the first 2 Ulam numbers.
# The first two numbers in an Ulam sequence are the lesser (U1) and the greater (U2) of $u and $v.
# Then for n > 2, Un is defined to be the smallest integer that is the sum of two distinct earlier terms in exactly one 
# way, and larger than all earlier terms.

my (@tests, $test, $max_terms, @times, $t, @ulam, $j, $k, $try, $next, $last, $ulam_j);

#          u  v  max
@tests = ([1, 2, 10], [2, 3, 10], [2, 5, 100], [123, 456, 500]);

for $test (@tests) {
	($ulam[1], $ulam[2], $max_terms) = @$test;
	say qq[\n$max_terms terms of the Ulam sequence starting with $ulam[1], $ulam[2]:];
	
	# loop over terms
	for $t (3 .. $max_terms) {
		
		# try all the preceding pairs
		@times = ();
		$last = $ulam[$t - 1];
		for $j (1 .. $t - 2) {
			$ulam_j = $ulam[$j];   # to optimise the inner loop
			for $k ($j + 1 .. $t - 1) {
				$times[$ulam_j + $ulam[$k]] ++;   # no of times that $try has been found
			}
		}
		
		# now find the smallest $try where $times[$try] == 1 (which will always exist, 
		# because ulam[$t - 1] + $ulam[$t - 2] must be a unique sum)
		for $try ($last + 1 .. $last + $ulam[$t - 2]) {
			next unless defined $times[$try];
			if ($times[$try] == 1) {   # got it!
				$ulam[$t] = $try;
				last;
			}
		}		
	}
	
	# and show the answer
	for $j (1 .. $max_terms) {
		print qq[$ulam[$j] ];
	}
	say '';
}

	