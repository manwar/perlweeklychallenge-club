#!/usr/bin/perl

# Peter Campbell Smith - 2022-01-24
# PWC 149 task 2

use v5.28;
use strict;
use warnings;
use utf8;

# Given a number base, derive the largest perfect square with no repeated digits and return 
# it as a string.

# The largest non-repeating number in eg base 4 is: 3210 = (3 * 4**3) + (2 * 4**2) + 1 * (4**1) + (0 * 4**0)
# So the largest non-repeating number in base n is: sum (j = 1 .. n-1) of j * n**j

my ($i, $square, $string, $test, @tests, $largest, $start);

# bases to try
@tests = (2, 4, 10, 12, 16, 17);

for $test (@tests) {
	
	# get largest possible number in base $test with no repeating digits (see above)
	$largest = 0;
	for $i (1 .. $test - 1) {
		$largest += $i * $test ** $i;
	}
	
	# can't do this if $largest can't be represented as an integer
	if ($largest > ~1 + 1) {
		say qq[$test is too large];
		next;
	}
	
	# find the largest square <= $largest
	$start = int(sqrt($largest));
	
	# generate squares down from there
	for ($i = $start; $i > 0; $i--) {
		$square = $i * $i;
		$string = basify($square, $test);    # convert to required format (eg 123AB)
		last if no_repeats($string);         # the answer!
	}
	say qq[f($test) = $string]
}

sub basify {   # ($integer, $base)

	my ($base, $digit, $digits, $integer, $result);
	
	# converts $integer to 123AB representation in base $base
	
	($integer, $base) = @_;
	$digits = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
	$result = '';
	
	# strip digits 1 at a time
	while ($integer) {
		$digit = $integer % $base;
		$integer = ($integer - $digit) / $base;
		$result = substr($digits, $digit, 1) . $result;
	}
	return $result;
}

sub no_repeats {   # ($string)

	my ($string, %seen);
	$string = $_[0];

	while ($string =~ m|(.)|g) {
		return 0 if $seen{$1};
		$seen{$1} = 1;
	}
	return 1;
}

	
