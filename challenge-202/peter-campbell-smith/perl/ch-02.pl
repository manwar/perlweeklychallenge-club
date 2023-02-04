#!/usr/bin/perl

# Peter Campbell Smith - 2023-01-30
# PWC 202 task 1

use v5.28;
use utf8;
use warnings;

# Task: Given a profile as a list of altitudes, return the leftmost widest valley. A valley is defined as a subarray 
# of the profile consisting of two parts: the first part is non-increasing and the second part is non-decreasing. 
# Either part can be empty.

# Blog: https://pjcs-pwc.blogspot.com/

my (@tests, $test, $j, $k, $is_bottom, $vl, $vr, @height, $rightmost, $widest, $width, $range);

@tests = ([1, 5, 5, 2, 8], [2, 6, 8, 5], [9, 8, 13, 13, 2, 2, 15, 17], [2, 1, 2, 1, 3], [1, 3, 3, 2, 1, 2, 3, 3, 2],
	[7, 7, 7, 7, 7], [1, 2, 3, 2, 2], [6, 5, 6, 5, 4, 3], [7, 8, 8, 7], [7], [1, 2, 3, 4], [4, 3, 2, 1]);

# loop over test values
for $test (@tests) {
	@height = @$test;
	$rightmost = scalar(@height) - 1;
	$widest = -1;
	
	# scan for low points that are at the bottom of a valley
	for $j (0 .. scalar(@height) - 1) {
		$is_bottom = 1;
		if ($j != 0) {
			$is_bottom = 0 if $height[$j - 1] < $height[$j];
		}
		if ($j != $rightmost) {
			$is_bottom = 0 if $height[$j + 1] < $height[$j];
		}
		next unless $is_bottom;
		
		# expand valley from bottom to the left
		$k = $vl = $j;
		while (-- $k >= 0) {
			last unless ($height[$k] >= $height[$vl]);
			$vl = $k;
		}
		
		# and from the bottom to the right
		$k = $vr = $j;
		while (++ $k <= $rightmost) {
			last unless ($height[$k] >= $height[$vr]);
			$vr = $k;
		}
		
		# is this the widest so far?
		$width = $vr - $vl + 1;
		if ($width > $widest) {
			$range = '';			
			$range .= qq[$height[$_], ] for $vl .. $vr;
			$widest = $width;
		}
	}
	
	# show results
	say qq[\nInput:  ] . join(', ', @$test) . qq[\nOutput: ] . substr($range, 0, -2);
}

