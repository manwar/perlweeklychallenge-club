#!/usr/bin/perl

# Peter Campbell Smith - 2022-12-19
# PWC 196 task 2

use v5.28;
use utf8;
use warnings;

# We are given a sorted unique integer array, @array. We are asked to find all the slices of this array
# which comprise consecutive integers, and output the first and last element in each such slice.

# Blog: https://pjcs-pwc.blogspot.com/2022/12/pattern-132-and-sequential-runs.html

my (@tests, $test, @array, $start, $in_slice, $output, $j);

# Mohammad's examples
@tests = ([1,3,4,5,7], [1,2,3,6,7,9], [0,1,2,4,5,6,8,9], [1,3,5,7,9,11]);

# loop over tests
TEST: for $test (@tests) {
	@array = @$test;
	
	# initialise
	$in_slice = 0;
	$output = '';
	say qq[\nInput:  \@array = (] . join(', ', @array) . ')';

	# add a number at the end of @array which is 2 more than the last one
	push @array, $array[scalar @array - 1] + 2;
	
	# loop over elements in @array
	for ($j = 0; $j < (scalar @array) - 1; $j ++) {
		
		# if we're not already in a sequence and the next element is one more than this, start a sequence
		unless ($in_slice) {
			if ($array[$j] == $array[$j + 1] - 1) {
				$start = $array[$j];
				$in_slice = 1;
			}
		
		# if we are already in a sequence, end it if the following element isn't one more than this
		} else {
			if ($array[$j] != $array[$j + 1] - 1) {
				$output .= qq[[$start, $array[$j]], ];
				$in_slice = 0;
			}
		}
	}
	if ($output) {
		say qq[Output: ]. substr($output, 0, -2);
	} else {
		say qq[Output: no consecutive sequence found];
	}
}
	
		
