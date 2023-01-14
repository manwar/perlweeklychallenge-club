#!/usr/bin/perl

# Peter Campbell Smith - 2023-01-09
# PWC 199 task 1

use v5.28;
use utf8;
use warnings;

# You are given a list of integers, @list. Write a script to find the total count of Good Pairs. 
# A pair (i, j) is called good if list[i] == list[j] and i < j.

# Blog: https://pjcs-pwc.blogspot.com/2023/01/all-good-things.html

my (@tests, $test, @list, $i, $j, $count, $rubric);
@tests = ([1, 2, 3, 1, 1, 3], [1, 2, 3], [1, 1, 1, 1], [1, 3, 5, 7, 9, 1, 3, 5, 7, 9, 1]);

# loop over tests
for $test (@tests) {
	
	# initialise
	@list = @$test;	
	$count = 0;
	$rubric = '';
	
	# loop over first candidate
	for $i (0 .. scalar(@list) - 2) {
		
		# loop over second candidate
		for $j ($i + 1 .. scalar(@list) - 1) {
			
			# check for goodness
			if ($list[$i] == $list[$j]) {
				$count ++;
				$rubric .= qq[($i, $j) - both equal $list[$i]\n];
			}
		}
	}
	
	# report
	say qq[Input:  (] . join(', ', @list). qq[)\nOutput: $count];
	say $rubric ? qq[Good pairs are:\n$rubric] : '';
}
