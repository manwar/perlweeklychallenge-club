#!/usr/bin/perl

# Peter Campbell Smith - 2023-01-23
# PWC 201 task 1

use v5.28;
use utf8;
use warnings;

# Task: You are given an array of unique numbers. Write a script to find out all missing numbers in the range 
# 0..$n where $n is the array size.

# Blog: https://pjcs-pwc.blogspot.com/2023/01/201-missing-numbers-and-piles-of-pennies.html

my (@tests, $test, $string, $j, $result);

@tests = ([0, 1, 3], [0, 1], [4, 5, 6], [6, 5, 4, 2, 1, 0], [0], []);

# loop over tests
for $test (@tests) {
	
	# make a string from the array
	$result = '';
	$string = ',' . join(',', @$test) . ',';   # $string = ,1,2,3,
	
	# check for missing numbers
	for $j (0 .. scalar @$test) {
		$result .= qq[$j, ] unless $string =~ m|,$j,|;
	}
	
	# report result
	$string =~ s|,|, |g;
	say qq[\nInput:  \$array = (] . substr($string, 2, -2) . ')';
	say qq[Output: ] . substr($result, 0, -2);
}	
