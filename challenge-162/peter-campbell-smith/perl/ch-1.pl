#!/usr/bin/perl

# Peter Campbell Smith - 2022-04-25
# PWC 162 task 1

use v5.28;
use strict;
use warnings;
use utf8;

# Write a script to generate the check digit of given ISBN-13 code.

my ($sum, $test, @digits, @multipliers, @tests);

# data
@tests = ('978-0-306-40615-7', '978-1-85345-445-5', '978-3-468-98143-2');

# multipliers of successive digits as defined
@multipliers = qw(1 3 1 3 1 3 1 3 1 3 1 3);

for $test (@tests) {
	
	# eliminate non-digits
	@digits = ();
	push @digits, $1 while $test =~ m|(\d)|g;
	
	# create weighted sum of first 12 digits
	$sum = 0;
	$sum += $digits[$_] * $multipliers[$_] for (0 .. 11);
	
	# and the 13th digit is 10 minus the sum, mod 10
	say qq[ISBN-13 check digit for '$test' is ] . (10 - $sum % 10) . '.';
}

