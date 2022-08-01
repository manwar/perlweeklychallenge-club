#!/usr/bin/perl

# Peter Campbell Smith - 2022-08-01
# PWC 176 task 1

use v5.28;
use utf8;
use warnings;

# Write a script to find the smallest integer x such that x, 2x, 3x, 4x, 5x and 6x are permuted 
# multiples of each other. For example, the integers 125874 and 251748 are permuted multiples 
# of each other.

# Blog: 

my ($j, $j_sorted, $j_length, $k, $jk, );

# method 1
say 142857;

# method 2

# loop from 10 to <big>
J: for $j (10 .. 1000000) {
	
	# sort the digits of $j and get its length
	$j_sorted = sorted($j);
	$j_length = length($j);
	
	# test 2x, 3x, 4x, 5x, 6x products
	for $k (2 .. 6) {
		$jk = $j * $k;
		
		# $j is no good if the product has more digits than $j, or they aren't the same digits
		next J if (length($jk) > $j_length or sorted($jk) ne $j_sorted);
	}
	
	# and if all that passes, we have the answer
	say $j;
	exit;
}

sub sorted {
	
	# sorts the characters of a string
	return join('', sort(split(//, $_[0])));
}
	
