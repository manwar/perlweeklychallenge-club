#!/usr/bin/perl

# Peter Campbell Smith - 2021-12-08
# PWC 142 task 1

use v5.20;
use warnings;
use strict;

# You are given positive integers, $m and $n.
# Write a script to find total count of divisors of $m having last digit $n.

# Some thoughts on this challenge: https://pjcs-pwc.blogspot.com/2021/12/perl-weekly-challenge-141-task-1-reads.html

my ($test, @tests, $m, $n, $string1, $string2, $divisor, $dividend, $count, $s);

# inputs - pairs of $m and $n
@tests = ([24, 2], [30, 5], [24, 7], [37, 0], [45, 5], [1048575, 5], [1048576, 2]);

# loop over tests
for $test (@tests) {
	($m, $n) = @$test;
	say qq[\nInput:  \$m = $m, \$n = $n];
	$count = 0;
	$string1 = $string2 = '';

	# loop over potential divisors
	for $divisor (1 .. $m) {
		$dividend = $m / $divisor;

		# if it is a divisor
		if ($dividend eq int($dividend)) {
			$string1 .= qq[$divisor, ];   # list of all divisors
			if ($divisor % 10 == $n) {
				$string2 .= qq[$divisor, ];   # list of divisors with last digit $n
				$count ++;
			}
		}
	}

	# tidy the ends of the strings
	for $s ($string1, $string2) {
		$s =~ s|, (\d+), $| and $1|;
	}
	
	# say the answers
	say qq[Output: $count];
	say qq[The divisors of $m are $string1];
	if ($string2) {
		say qq[There are only $count divisors with last digit $n: $string2];
	} else {
		say qq[There are no divisors with last digit $n];
	}

}
