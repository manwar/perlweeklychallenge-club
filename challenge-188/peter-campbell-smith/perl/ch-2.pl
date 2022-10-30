#!/usr/bin/perl

# Peter Campbell Smith - 2022-10-26
# PWC 188 task 2

use v5.28;
use utf8;
use warnings;
binmode(STDOUT, ':utf8');

# You are given two positive integers $x and $y. Write a script to find out the number of operations needed to 
# make both ZERO. Each operation is made up either of the following:
# $x = $x - $y if $x >= $y -or- $y = $y - $x if $y >= $x 

# Note: I believe the problem as stated is impossible and submit a solution which counts the number of operations
# until either x or y becomes zero, which matches the supplied examples.

# Blog: 

my (@tests, $x, $y, $ops);

# test input (pairs of x, y)
@tests = (5, 4,  4, 6,  2, 5,  3, 1,  7, 4, 987, 654);

# loop over tests
TEST: while ($tests[0]) {
	
	# initialise
	$x = shift @tests;
	$y = shift @tests;
	$ops = 0;
	say qq[\nInput:  \$x = $x, \$y = $y];
	
	# apply rules
	while ($x > 0 and $y > 0) {
		if ($x >= $y) {
			$x -= $y;
		} else {
			$y -= $x;
		}
		$ops ++;
	say qq[x $x y $y];
	}
	# and the answer
	say qq[Output: $ops];
}

