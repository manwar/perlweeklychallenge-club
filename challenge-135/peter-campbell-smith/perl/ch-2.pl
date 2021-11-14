#!/usr/bin/perl

# Peter Campbell Smith - 2021-10-18
# PWC 135 task 2

use v5.20;
use warnings;
use strict;

# You are given 7-characters alphanumeric SEDOL.

# Write a script to validate the given SEDOL. 
# Print 1 if it is a valid SEDOL otherwise 0.

# A valid SEDOL:
# is 7 characters long
# has the first 6 chars matching [B-DF-HJ-NP-TV-Z0-9]
# has a digit 0-9 as the last char
# has a weighted sum of digits (see @weights) which is a multiple of 10

my (@weights, $sedol, @tests);

@weights = (1, 3, 1, 7, 3, 9, 1);   # weight of each char in the checksum (from Wikipedia)

# check some known valid SEDOLs (taken from London Stock Exchange listings)
say "\n--- VALID ---";
@tests = qw[0263494 B7S9G98 B1VZ0M2 B12WC93 B6T5S47 BDZWB75 BLGZ986 0798059];
for $sedol (@tests) {
	check_sedol($sedol);
}

# check some known invalid SEDOLs
say "\n--- INVALID ---";
@tests = qw[BBBBBBB CCCCCC ZZZZAZ0 BCDFGH* BDZWB76 1798059];
for $sedol (@tests) {
	check_sedol($sedol);
}

sub check_sedol {
	
	my ($SEDOL, $check_sum, $j, $char, $char_value);

	$SEDOL = $_[0];
	say qq[\nInput:  \$SEDOL = $SEDOL];

	# check length and valid chars
	unless ($SEDOL =~ m|^[B-DF-HJ-NP-TV-Z0-9]{6}\d$|) {
		say qq[Output: 0 (wrong length or invalid chars)];
		return;
	}
	
	# calculate checksum
	@weights = (1, 3, 1, 7, 3, 9, 1);
	$check_sum = 0;
	for $j (0..6) {
		$char = substr($SEDOL, $j, 1);
		$char_value = ord($char) - ($char =~ m|\d| ? ord('0') : ord('A') - 10);
		$check_sum += $weights[$j] * $char_value;
	}

	# is it a multiple of 10?
	if ($check_sum % 10 == 0) {
		say 'Output: 1';
	} else {
		say qq[Output: 0 (checksum is $check_sum - not a multiple of 10)];
	}
}
