#!/usr/bin/perl

use strict;
use warnings;

# PWC 130 task 1 - Peter Campbell Smith - 2021-09-14

# You are given an array of positive integers, such that all 
# the numbers appear even number of times except one number.
# Write a script to find that integer.

# There is no way to solve this without inspecting every element
# of the array. One approach would be to sort the array
# and look for the first odd-length sequence, but it is
# unlikely that the sort can be done more cheaply than the
# simple algorithm shown below.

my (@N, $j, %count);

# sample data (3 is the answer)
@N = (1, 2, 3, 4, 3, 2, 1, 4, 4, 3, 4);

# get $count{$j} == number of instances of $j
for $j (@N) {
	$count{$j}++;
}

# look for the first instance of $count{$j} being odd                                                                 
for $j (keys %count) {
	if ($count{$j} & 1) {
		print qq[The answer is $j\n];
		last;
	}
}
