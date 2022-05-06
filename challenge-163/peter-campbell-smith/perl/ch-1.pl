#!/usr/bin/perl

# Peter Campbell Smith - 2022-05-03
# PWC 163 task 1

use v5.28;
use strict;
use warnings;
use utf8;

# You are given list positive numbers, @n.
# Write a script to calculate the sum of bitwise & operator for all unique pairs.

# Blog: https://pjcs-pwc.blogspot.com/2022/05/lot-of-ands-and-strange-grid.html

my (@tests, $test, @n, $last, $i, $j, $term, $sum, $since1, $since2);

@tests = ([1, 2, 3], [2, 3, 4], [12, 32, 43, 72, 34, 99, 6, 50]);

# loop over tests
for $test (@tests) {
	@n = @$test;
	say qq[\nInput:  \@n = (] . join(', ', @n) . ')';

	# loop over unique pairs
	$sum = 0;
	$since1 = $since2 = '';
	$last = scalar @n;
	for $i (0 .. $last - 2) {
		for $j ($i + 1 .. $last - 1) {
			
			# create sum and 2 output strings
			$term = $n[$i] & $n[$j];
			$sum += $term;
			$since1 .= qq[($n[$i] & $n[$j]) + ];
			$since2 .= qq[$term + ];
		}
	}

	# show result
	say qq[Output: $sum\nSince ] . substr($since1, 0, -3) . ' => ' .
		substr($since2, 0, -3) . qq[ => $sum];

}
