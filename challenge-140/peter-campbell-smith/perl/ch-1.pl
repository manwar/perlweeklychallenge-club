#!/usr/bin/perl

# Peter Campbell Smith - 2021-11-22
# PWC 140 task 1

use v5.20;
use warnings;
use strict;

# You are given two decimal-coded binary numbers, $a and $b.

# Write a script to simulate the addition of the given binary numbers.
# The script should simulate something like $a + $b. (operator overloading)

my (@tests, $a, $b);

# pairs to be added
@tests = (11, 1,   101, 1,   100, 11,   10101, 1010,   0, 111,   1111111111, 1111111111);

while (1) {
	
	# pick off next pair
	$a = shift @tests;
	last unless length($a);
	$b = shift @tests;
	
	# give answer
	say qq[$a + $b = ] . dec_to_bin(bin_to_dec($a) + bin_to_dec($b));
}

sub bin_to_dec {
	
	# converts a string of 0s and 1s to a decimal value
	my ($arg, $result);
	
	$arg = $_[0];
	$result = 0;
	
	# process digits
	while ($arg =~ m|^(.)(.*)$|) {
		$result = 2 * $result + $1;
		$arg = $2;
	}
	return $result;
}

sub dec_to_bin {
	
	# coverts a decimal number to binary representation
	return sprintf('%b', $_[0]);
}
