#!/usr/bin/perl

# Peter Campbell Smith - 2022-11-21
# PWC 192 task 1

use v5.28;
use utf8;
use warnings;

# You are given a positive integer, $n. Write a script to find the binary flip, which is the number
# whose binary representation has 1s where $n has 0s and vice versa.

# Blog: https://pjcs-pwc.blogspot.com/2022/11/flipping-easy-and-distributing-fairly.html

my (@tests, $test, $flip);

@tests = (5, 4, 6, 127, 128, 1234, 999999, 7294019678);

# loop over tests
while ($test = shift @tests) {
	$flip = sprintf('%b', $test);
	say qq[\nInput:  $test = 0b$flip];
	
	# 'not' the input and remove leading ones
	$flip = sprintf('%b', ~ $test);
	$flip =~ s|^1+||;
	say qq[Output: ] . oct('0b' . $flip) . qq[ = 0b$flip];	 
}
