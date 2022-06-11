#!/usr/bin/perl

# Peter Campbell Smith - 2022-03-17
# PWC 156 task 1

use v5.28;
use strict;
use warnings;
use utf8;
use Math::Prime::Util 'is_prime';

# Write a script to permute (compute?) first 10 Pernicious Numbers. A pernicious number is a positive 
# integer which has prime number of ones in its binary representation.

# blog: https://pjcs-pwc.blogspot.com/2022/03/pernicious-and-weird.html

my ($found, $j, $binary, @ones, $count);

# loop over numbers 1 to big
$found = 0;
for $j (1 .. 100) {
	
	# convert to binary
	$binary = sprintf('%b', $j);
	
	# get a list of the '1' matches and assign it to an array
	@ones = $binary =~ m|1|g;
	
	# count the number of elements in the array
	$count = scalar @ones;
	
	# and we have an answer if the count is prime
	next unless is_prime($count);
	say $j;	
	last if $found ++ == 9;
}
