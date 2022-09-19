#!/usr/bin/perl

# Peter Campbell Smith - 2022-08-08
# PWC 177 task 2

use v5.28;
use utf8;
use warnings;
use Math::Prime::Util 'is_prime';

# Write a script to generate first 20 Palindromic Prime Cyclops Numbers.
# A cyclops number is a number with an odd number of digits that has a zero in the center only.

# Blog: https://pjcs-pwc.blogspot.com/2022/08/damm-algorithm-take-care-to-spell-that.html

my ($j, $count, $test, $string);

# loop from 1 upwards - $j is the digits before the middle 0
for $j (1 .. 2 ** 31) {
	
	# no good if $j has a zero in it
	next if $j =~ m|0|;
	
	# create $j . 0 . reverse of $j
	$test = $j . '0' . join('', reverse(split('', $j)));
	
	# but is it prime?
	next unless is_prime($test);
	
	# it is
	$string .= qq[$test, ];
	last if ++ $count == 20;
	$string .= qq[\n] unless $count % 7;
}
say substr($string, 0, -2);
		