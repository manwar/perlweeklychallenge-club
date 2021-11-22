#!/usr/bin/perl

# Peter Campbell Smith - 2021-11-15
# PWC 139 task 1

use v5.20;
use warnings;
use strict;

# You are given a list of numbers.

# Write a script to implement JortSort. It should return true/false depending 
# if the given list of numbers are already sorted.

my ($lists, $list, $this, $result, $prev);

# inputs to test
$lists = [[1, 2, 3, 4, 5], [1, 2, 5, 4, 3], [2, 1, 3, 4, 5], [1, 100, 100, 12345, 123456789, 123456788], 
	[-1, 0, 0, 0, 0, 1], [-100..100, 99],
	[12.34, 12.35, 12.36], [-1e6 + 0.1, -1e5-0.1, 1e4 + 0.1, 1e4 + 0.100001]];

# loop over inputs
for $list (@$lists) {
	say 'Input:  ' . join(', ', @$list);
	
	# assume good until proved otherwise
	$result = 1;
	$prev = $list->[0];
	for $this (@$list) {
		$result = $this < $prev ? 0 : 1;
		last unless $result;   # no need to check the rest of the list
		$prev = $this;
	}
	say "Output: $result\n";
}
