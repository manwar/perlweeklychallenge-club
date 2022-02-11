#!/usr/bin/perl

# Peter Campbell Smith - 2022-01-31
# PWC 150 task 2

use v5.28;
use strict;
use utf8;

# You are planning to rob a row of houses, always starting with the first 
# and moving in the same direction. However, you can’t rob two adjacent houses.
# Write a script to find the highest possible gain that can be achieved.

my (@tests, $test, @houses, $last, $best);

@tests = ([2, 4, 5], [4, 2, 3, 6, 5, 3],
	[32, 32, 8, 12, 46, 28, 79, 81, 84, 23, 48, 88, 38, 36, 44, 45, 55, 74, 33, 54, 49, 33, 54, 50, 20, 45, 79, 94, 48,
	94, 51, 93, 88, 23, 19]);

# loop over tests
for $test (@tests) {
	
	@houses = @$test;	
	say qq[\nInput: ] . join(' ', @$test);
	$best = 0;
	$last = scalar @houses - 1;
	
	# start at house 0 and we've got $houses[0] in the swag bag
	robberies(0, $houses[0]);
	say qq[Output: $best];
}

sub robberies {
	
	# robberies($number, $swag) updates $best with the best result starting from house $number
	# with $swag already in the bag
		
	my ($number, $swag, $next, $new_swag);
	
	($number, $swag) = @_;	
	# try all the next allowable houses starting from $number
	for ($next = $number + 2; $next <= $last; $next ++) {
		$new_swag = $swag + $houses[$next];
		$best = $new_swag if $new_swag > $best;   # looking good!
		robberies($next, $new_swag);
	}
}