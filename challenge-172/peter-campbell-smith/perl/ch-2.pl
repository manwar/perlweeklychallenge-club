#!/usr/bin/perl

# Peter Campbell Smith - 2022-07-07
# PWC 171 task 2

use v5.28;
use strict;
use warnings;
use utf8;
binmode(STDOUT, ':utf8');

# You are given an array of integers.  Write a script to compute the five-number 
# summary (FNS) of the given set of integers.  Wikipedia tells us that the FNS
# comprises the minimum, 1st quartile, median, 3rd quartile and maximum of the set.

# Blog: https://pjcs-pwc.blogspot.com/2022/07/tricky-partitions-and-easy-stats.html

my (@tests, $test, @sorted, $count, $median, $first_quartile, $third_quartile);

@tests = ([1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
	[8, 42, -3, 0, 99, 66, 21, 100], 
	[1, 1, 1, 1, 1, 1, 1],
	[1, 2, 3, 4, 5, 6, 7, 8, 1000],
	[20,67,81,14,54,53,78,6,47,54,51,93,38,40,98,60,26,24,27,12,85,36,93,40,55,73,6,47,41,
	64,39,86,1,71,92,19,14,54,5,59,65,77,34,45,78,27,68,51,24,4,97,69,4,9,55,85,6,95,51,45,
	88,54,52,5,29,64,84,83,89,31,76,92,10,49,3,2,88,59,77,68,16,85,59,57,52,65,79,48,90,67,
	90,27,25,56,45,58,82,49,51,58]);

# loop over tests
for $test (@tests) {
	
	# sort numerically and count
	@sorted = sort	{$a <=> $b} @$test;
	$count = scalar @sorted;

    # determine value at a position (which might not be integral)
	$median = value(($count - 1) / 2);
	$first_quartile = value(($count - 1) / 4);
	$third_quartile = value(3 * ($count - 1) / 4);
	
	# show the answers
	say qq[\n] . join(', ', @sorted);
	say qq[minimum $sorted[0] first quartile $first_quartile median $median ] .
		qq[third quartile $third_quartile maximum $sorted[$count - 1]];
	
}

sub value {
	
	my ($position, $lower, $upper, $fraction);
	
	# returns the value at the given position
	# if position is non-integral returns the weighted intermediate value
	$position = shift;
	
	# integral position
	return $sorted[$position] if $position == int($position);
	
	# find intergral position below and above given position and 
	# calculate weighted intermediate value
	$lower = int($position);
	$upper = $lower + 1;
	$fraction = $position - $lower;
	return $sorted[$lower] * (1 - $fraction) + $sorted[$upper] * $fraction;
}	
