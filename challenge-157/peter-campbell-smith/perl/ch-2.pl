#!/usr/bin/perl

# Peter Campbell Smith - 2022-03-22
# PWC 157 task 1

use v5.28;
use strict;
use warnings;
use utf8;

# Write a script to find out if a given number $n > 3 is a Brazilian Number.
# My interpretation of the definition is that a number is Brazilian if its
# representation in any base consists of the same digit repeated more than
# once, eg 333 or fffff, but not 11.

# Blog: https://pjcs-pwc.blogspot.com/2022/03/mean-brazilians.html

my (@tests, $n, $base, $based, $brazilian, $reason);

# tests as stated in the challenge and then some more
@tests = (7, 6, 8, 9 .. 200);

say qq[\n--- Solution to task: ---];

# loop over numbers to be tested
for $n (@tests) {
	$reason = '';
	
	# loop over possible bases (see blog for why we can stop at $n / 2)
	for $base (2 .. int($n / 2)) {
		$based = base($n, $base);
		$brazilian = $based =~ m|^(.)\1+$|;  # succeeds if the first character is followed by 1+ repeats of the same
		
		# it is, and we can stop looking
		if ($brazilian) {
			say qq[\nInput:  \$n = $n\nOutput: 1\nSince $n in base $base is $based];
			last;
		}
		$reason .= qq[\n      $n in base $base is $based];
	}
	
	# so we've been through all the bases and it isn't brazilian
	say qq[\nInput:  \$n = $n\nOutput: 0\nSince] . substr($reason, 6) unless $brazilian;
	
	say qq[\n --- And some more results: ---] if $n == 8;
}

sub base {

	my ($base, $digit, $digits, $integer, $result);
	
	# converts $integer to 123AB representation in base $base
	# nicked from week 149 task 2
	
	($integer, $base) = @_;
	$digits = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz!"£$%^&*()';
	$result = '';
	
	# strip digits 1 at a time
	while ($integer) {
		$digit = $integer % $base;
		$integer = ($integer - $digit) / $base;
		$result = substr($digits, $digit, 1) . $result;
	}
	return $result;
}
