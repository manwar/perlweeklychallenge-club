#!/usr/bin/perl

# Peter Campbell Smith - 2021-11-08
# PWC 138 task 2

use v5.20;
use warnings;
use strict;

# You are given a perfect square.
# Write a script to figure out if the square root of the given number is 
# same as the sum of 2 or more splits of the given number, eg sqrt(9801) = 98 + 0 + 1 = 99

# Discussion: The tricky requirement is to generate all the splits of a
# multi-digit number (eg 123456).  Consider the number as a string of n digits.
# Consider also a binary number with n - 1 digits (eg 01101).  If we generate
# all such binary numers, and consider each bit to represent whether the
# corresponding digit in the split is followed by ' + ', we can generate
# all the splits.  So for example 123456 and 01101 yields 12 + 3 + 45 + 6:
# a plus has been inserted after the first, second and fifth digits of n
# because the first, second and fifth bits of the binary number are 1.
#
# Once you have all the splits you can 'eval' them to get the sum, and compare
# it with sqrt(n).
#
# There is one slight catch. If n contains am embedded 0 (eg 123056) then
# you will get splits like 123 + 056.  Perl regards 056 as octal 56, so it
# is necessary to remove these leading zeroes before the eval.

my (@squares, $square, $root, $gaps, $plus_map, $position, $result, $sum, $since, $good, 
	$legend0, $legend1, $result2);

# test values
@squares = (81, 9801, 36**2, 45**2, 55**2, 82**2, 91**2, 92**2, 777**2);

# loop over test values
for $square (@squares) {
	
	# check it really is a sqare
	$root = sqrt($square);
	say qq[Input: $square ($root ** 2)];
	if ($root != int($root) or $square < 10) {
		say qq[$square is not an integer square >= 10\n];
		next;
	}
	
	# initialisation
	$gaps = length($square) - 1;   # no of gaps where we could insert a +
	$good = 0;
	$since = '';
	$legend1 = qq[Output: 1\nsince];
	$legend0 = qq[Output: 0\nsince];
	
	# loop over binary numbers eg if $gaps == 6, from 000001 to 111111
	for $plus_map (1 .. 2 ** $gaps - 1) {
		
		# create a string containing pluses in the appropriate places (eg 123 + 456)
		$result = '';
		for $position (0 .. $gaps) {
			$result .= substr($square, $position, 1);
			if ($plus_map & (2 ** $position)) {   # use bitwise & to isolate the appropriate bit
				$result .= ' + ';
			}
		}
		
		# need to avoid constructs like + 012 as perl regards 012 as an octal number
		$result2 = $result;
		$result2 =~ s| 0(\d)| $1|g;
		
		# evaluate the string
		$sum = eval($result2);
		
		# good result - sums to the root of the original number - show it
		if ($sum == $root) {
			say qq[$legend1 $result == $sum];
			$good = 1;
			$legend1 = 'and  ';
			
		# bad result - it doesn't; keep this in $since in case no good result is found
		} else {
			$since .= qq[$legend0 $result == $sum != $root\n];
			$legend0 = 'and  ';
		}
	}
	
	# if there were no good results, list the bad ones
	print $good ? qq[\n] : qq[$since\n];
}
