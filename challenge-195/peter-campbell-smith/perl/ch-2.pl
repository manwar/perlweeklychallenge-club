#!/usr/bin/perl

# Peter Campbell Smith - 2022-12-12
# PWC 195 task 1

use v5.28;
use utf8;
use warnings;

# You are given a list of numbers, @list. Write a script to find most frequent even numbers in the list. If
# you get more than one with the same frequency return the smallest. For all other case, return -1.

# Blog: https://pjcs-pwc.blogspot.com/2022/12/some-numbers-are-special-and-others-are.html

my (@tests, $test, @freq, $max_freq, $max_freq_no, $j, @list);

@tests = ([1,1,2,6,2], [1,3,5,7], [6,4,4,6,1], [23, 46, 72, 15, 0, 33, 34, 72, 1, 99, 1000, 14], 
	[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 0], [1 .. 100], [1, 3, 5, 7, 9, 11, 13,15, 17, 19], [8, 8, 6, 6, 4, 4, 2, 2]);

# loop over tests
for $test (@tests) {
	
	# initialise
	$max_freq = 0;
	$max_freq_no = -1;
	@freq = ();
	
	# look at each member of input list, sorted numerically so that we see the smallest first
	for $j (sort {$a <=> $b} @$test) {
		
		# ignore it if it is odd
		next if $j & 1;
		
		# increment its frequency
		$freq[$j] ++;
		
		# if more that the highest seen so far, remember it
		if ($freq[$j] > $max_freq) {
			$max_freq = $freq[$j];
			$max_freq_no = $j;
		}
	}
	
	# and show the result
	say qq[\nInput:  \@list = (] . join(', ', @$test) . qq[)\nOutput: $max_freq_no];

}
