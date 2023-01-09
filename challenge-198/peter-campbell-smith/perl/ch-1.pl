#!/usr/bin/perl

# Peter Campbell Smith - 2023-02-03
# PWC 198 task 1

use v5.28;
use utf8;
use warnings;

# You are given a list of integers, @list. Write a script to find the total pairs in the sorted list 
# where 2 consecutive elements have the max gap. If the list contains less then 2 elements then return 0.

# Blog: https://pjcs-pwc.blogspot.com/2023/01/mind-gap.html

my (@tests, $test, @list, $gap, $max_gap, $j, $count, $explain);
@tests = ([2, 5, 8, 1], [3], [2, 8, 5, 1, 7], [1, 5, 9, 10, 14]);

# loop over tests
for $test (@tests) {
	
	# sort list numerically
	@list = sort {$a <=> $b} @$test;
	
	# intialise
	$count = 0;
	$max_gap = 0;
	$explain = '';
	
	# loop over consecutive pairs
	for $j (0 .. scalar(@list) - 2) {
		$gap = $list[$j + 1] - $list[$j];
		
		# new $max_gap
		if ($gap > $max_gap) {
			$max_gap = $gap;
			$count = 1;
			$explain = qq[($list[$j], $list[$j + 1]) and ];
			
		# additional pair with $max_gap	
		} elsif ($gap == $max_gap) {
			$count ++;
			$explain .= qq[($list[$j], $list[$j + 1]) and ];
			
		# $gap < $max_gap - ignore	
		} else {
			next;
		}
	}
	
	# format and say output
	say qq[\nInput:  (] . join(', ', @$test) . qq[)];
	say qq[Output: $count - ] . substr($explain, 0, -5);
}
