#!/usr/bin/perl

# Peter Campbell Smith - 2022-03-30
# PWC 158 task 1

use v5.28;
use strict;
use warnings;
use utf8;

# You are give an array of integers, @n. Write a script to find out the 
# Equilibrium Index of the given array, if found. For an array A consisting
# of n elements, index i is an equilibrium index if the sum of elements of 
# subarray A[0…i-1] is equal to the sum of elements of subarray A[i+1…n-1].

# It doesn't say positive or non-zero integers, so we'd better allow for that.
# However, if 0 is allowed there may not be a unique answer (eg 4, 5, 0, 0, 4, 5)
# and the same for negative numbers (eg -3, 3, 0, -4, 4, 0, -5, 5).
# Also, it doesn't say that the elements are sorted (and the 3rd example isn't).
# So really we just have to test every possibility.

my (@tests, $test, $last, $try, $left, $right, $j, %tried, $string);

@tests = ([1, 3, 5, 7, 9],
		  [1, 2, 3, 4, 5],
		  [2, 4, 2], 
		  [1, 2, 3, 4, 5, 6, 0, 21],
		  [14, -12, -26, 7, -24],
		  [15, 1, 5, 5, 5], 
		  [5, 5, 5, 1, 15], 
		  [3, -3, 8], 
		  [4, 5, 0, 0, 4, 5], 
		  [-3, 3, 0, -4, 4, 0, -5, 5]);

for $test (@tests) {
	
	# format input
	$string = qq[\nInput:  (];
	for $j (@$test) {
		$string .= qq[$j, ];
	}
	say substr($string, 0, -2) . ')';
	
	# check every possibility (see comments at top)
	$last = scalar @$test;
	for $j (1 .. $last - 2) {
		$left = sum_of($test, 0, $j - 1);
		$right = sum_of($test, $j + 1, $last - 1);
		
		# found an answer
		if ($left == $right) {
			say qq[Output: $j];
			last;
		}
	}
	
	# no EI found
	say qq[Output: -1 as no Equilibrium Index found] unless $left == $right;
}
	
sub sum_of {
	
	# returns sum of $array[$left] .. $array[$right]
	my ($array, $left, $right) = @_;
	my ($j, $sum);
	$sum = 0;
	for $j ($left .. $right) {
		$sum += $array->[$j];
	}
	return $sum;
}
	
	
	


