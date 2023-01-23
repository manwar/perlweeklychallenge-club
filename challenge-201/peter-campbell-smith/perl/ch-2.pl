#!/usr/bin/perl

# Peter Campbell Smith - 2023-01-23
# PWC 201 task 2

use v5.28;
use utf8;
use warnings;

# Task: You are given an integer, $n > 0. Write a script to determine the number of ways of putting $n 
# pennies in a row of piles such that each pile contains no fewer pennies than the one on its left.

# Blog: https://pjcs-pwc.blogspot.com/2023/01/201-missing-numbers-and-piles-of-pennies.html

my (@tests, $n, $ways, $piles);

@tests = (1, 2, 3, 4, 5, 20);

# loop over tests
for $n (@tests) {
	
	# initialise
	$ways = 0;
	$piles = '';
	
	# find possible ways to do it
	find_ways($n, $n, '');
	
	# output results
	say qq[Input:  \$n = $n\nOutput: ] . $ways;
	say qq[Piles:\n$piles];
}	

sub find_ways {
	
	# returns the number of possible ways of stacking $pennies pennies in stacks no more than $height
	my ($pennies, $height, $stack) = @_;
	my ($h);

	# no pennies left - answer found
	if ($pennies == 0) {
		$piles .= qq[$stack\n];
		$stack = '';
		$ways ++;
		return;
	}
	
	# loop over possible piles
	for $h (1 .. ($pennies > $height ? $height : $pennies)) {
		find_ways($pennies - $h, $h, qq[$h $stack]);
	}
}
