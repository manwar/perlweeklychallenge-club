#!/usr/bin/perl

# Peter Campbell Smith - 2022-01-31
# PWC 150 task 1

use v5.28;
use strict;
use warnings;
use utf8;

# You are given two strings having same number of digits, $a and $b.
# Write a script to generate Fibonacci Words by concatenation of the previous two 
# strings. Finally print 51st digit of the first term having at least 51 digits.

my ($a, $b, $index, $j, $test, @fib, @tests);

# sets of inputs to test ($a, $b, character index of interest)
@tests = (['1234', '5678', 51], ['12345678', '98765432', 159], ['1', '2', 1000]);

# loop over tests
for $test (@tests) {
	
	# get parameters
	($fib[0], $fib[1], $index) = @$test;
	
	# create successive ternms of series until one is long enough
	$j = 1;
	while (1) {
		$j ++;
		$fib[$j] = $fib[$j - 2] . $fib[$j - 1];
		last if length($fib[$j]) >= $index;
	}
	
	# format the answer
	say qq[\nInput:  $fib[0], $fib[1]];
	say qq[Term $j is $fib[$j] (] . length($fib[$j]) . ' characters long)';
	say qq[Character $index is ] . substr($fib[$j], $index - 1, 1);
}
