#!/usr/bin/perl

# Peter Campbell Smith - 2021-11-22
# PWC 140 task 2

use v5.20;
use warnings;
use strict;

# You are given 3 positive integers, $i, $j and $k.
# Write a script to print the $kth element in the sorted 
# multiplication table of $i and $j.

my (@tests, $test, $i, $j, $k, @results, $i0, $j0);

# i, j, k sets to be tested
@tests = ([2, 3, 4], [3, 3, 6], [20, 30, 599], [1000, 999, 314159]);

# loop over tests
for $test (@tests) {
	
	# we want the $nth product in $results[$n] so dummy out $results[0]
	@results = (0);
	($i, $j, $k) = @$test;
	say qq[Input:  \$i = $i, \$j = $j, \$k = $k];
	
	# make table
	for $i0 (1 .. $i) {
		for $j0 (1 .. $j) {
			push (@results, $i0 * $j0);
		}
	}
	
	# sort results and print desired one
	@results = sort {$a <=> $b} @results;
	
	say qq[Output: $results[$k]\n];
}

