#!/usr/bin/perl

# Peter Campbell Smith - 2022-11-14
# PWC 191 task 1

use v5.28;
use utf8;
use warnings;

# You are given list of integers, @list. Write a script to find out whether the largest item in the list 
# is at least twice as large as each of the other items.

# Blog: https://pjcs-pwc.blogspot.com/2022/11/the-twice-largest-and-number-of-cuties.html

my (@tests, $test, @sorted, $largest, $second, $this);

@tests = ([1, 2, 3, 4], [1, 2, 0, 5], [2, 6, 3, 1], [4, 5, 2, 3], [1, 5, 16, 28, 35, 44, 50, 61, 78, 83, 99, 200]);

# loop over tests
while ($test = shift @tests) {
	
	# method A
 	 @sorted = reverse sort {$a <=> $b} @$test;
	 say qq[\nInput:    \@list = (] . join(', ', @$test) . qq[)\nOutput A: ] . ($sorted[0] >= 2 * $sorted[1] ? '1' : '-1');

	# method B 
	$largest = $second = 0;
	for $this (@$test) {
		if ($this > $largest) {
			$second = $largest;
			$largest = $this;
		}
	 }
	 say qq[Output B: ] . ($largest >= 2 * $second ? '1' : '-1');		 
}
