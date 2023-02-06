#!/usr/bin/perl

# Peter Campbell Smith - 2023-01-30
# PWC 202 task 1

use v5.28;
use utf8;
use warnings;

# Task: You are given an array of integers. Write a script to print 1 if there are THREE consecutive odds 
# in the given array otherwise print 0.

# Blog: https://pjcs-pwc.blogspot.com/

my (@tests, $test, @bits, $string);

@tests = ([1, 5, 3, 6], [2, 6, 3, 5], [1, 2, 3, 4], [2, 3, 5, 7], [1, 11, 111], [2, 22, 222]);

# loop over tests
for $test (@tests) {
	
	# create a string having 1 for an odd number and 0 for an even number
	# and see if the string matches 111
	say qq[\nInput:  \@array = (] . join(', ', @$test) . ')';
	say qq[Output: ] . (join('', map({ $_ & 1 } @$test)) =~ m|111| ? 1 : 0);
}	
