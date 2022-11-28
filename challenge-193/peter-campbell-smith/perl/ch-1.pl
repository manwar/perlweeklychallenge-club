#!/usr/bin/perl

# Peter Campbell Smith - 2022-11-28
# PWC 193 task 1

use v5.28;
use utf8;
use warnings;

# You are given an integer, $n > 0. Write a script to find all possible binary numbers of length $n.

# Blog: https://pjcs-pwc.blogspot.com/2022/11/all-binaries-and-find-odd-man-out.html

my (@tests, $n, $j, $string);

@tests = (2, 3, 4, 10);

# loop over tests
for $n (@tests) {
	
	# format as binary
	$string = '';
	$string .= sprintf("%0${n}b", $_) . ', ' for (0 .. 2 ** $n - 1);
	
	# show output
	say qq[\nInput:  $n\nOutput: ] . substr($string, 0, -2);
}
