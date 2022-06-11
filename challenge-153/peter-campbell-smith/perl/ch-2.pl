#!/usr/bin/perl

# Peter Campbell Smith - 2022-02-21
# PWC 153 task 2

use v5.28;
use strict;
use utf8;

# You are given an integer, $n.
# Write a script to figure out if the given integer is factorion.
# A factorion is a natural number that equals the sum of the factorials of its digits.

my (@tests, $test, $sum, @fac, $n, $not, $string1, $string2);

# numbers to test
@tests = (1, 2, 3, 4, 125, 145, 40585, 57778);

# calculate factorials of single digits
$fac[0] = 1;
for $n (1 .. 9) {
	$fac[$n] = $n * $fac[$n - 1];
}

# loop over tests
for $test (@tests) {
	$sum = 0;
	$string1 = $string2 = '';
	
	# test for being a factorion
	while ($test =~ m|(\d)|g) {
		$sum += $fac[$1];
		$string1 .= qq[$1! + ];
		$string2 .= qq[$fac[$1] + ];
	}
	
	# format output
	say qq[\nInput:  $test];
	$string1 =~ s|...$||;
	$string2 =~ s|...$||;
	if ($sum == $test) {
		say qq[Output: 1 since $string1 => $string2 = $test];
	} else {
		say qq[Output: 0 since $string1 => $string2 = $sum <> $test];
	}
}
