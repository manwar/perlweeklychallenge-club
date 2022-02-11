#!/usr/bin/perl

# Peter Campbell Smith - 2022-01-31
# PWC 150 task 1

use v5.28;
use strict;
use utf8;

# You are given binary tree. Write a script to find the minimum depth.
# The minimum depth is the number of nodes from the root to the nearest leaf node 
# (node without any children).

# Note: this assumes that all occupied nodes contain a single character.  if that
# were not the case, the same algorithm would work using an array rather than
# a string to represent the contents of each level.

my (@tests, $test, @levels, $level, $child1, $child2, $j);

@tests = ('1 | 2 3 | 4 5', '1 | 2 3 | 4 *  * 5 | * 6', '1|23|4567|890123456|7');

# loop over tests
TEST: for $test (@tests) {
	say qq[\nInput:  $test];
	$test =~ s/ //g;    # eliminate spaces from test string
	
	# split levels into array
	@levels = split(/\|/, $test);
	
	# loop over levels
	for ($level = 0;; $level ++) {   # loop over levels
	
		# loop over nodes within level
		for $j (0 .. 2 ** $level - 1) {

			# for the jth node in this level the children are in the next level at 2j and 2j+1
			$child1 = substr($levels[$level + 1], 2 * $j, 1);
			$child2 = substr($levels[$level + 1], 2 * $j + 1, 1);

			# if neither child exists we have reached the shortest branch
			if ((! $child1 or $child1 eq '*') and (! $child2 or $child2 eq '*')) {
				say qq[Output: ] . ($level + 1);
				next TEST;
			}
		}
	}
}
			
			
