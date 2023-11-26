#!/usr/bin/perl

# Task 2: Prime Order
# 
# You are given an array of unique positive integers greater than 2.
# 
# Write a script to sort them in ascending order of the count of their prime factors, tie-breaking by ascending value.
# Example 1
# 
# Input: @int = (11, 8, 27, 4)
# Output: (11, 4, 8, 27))
# 
# Prime factors of 11 => 11
# Prime factors of  4 => 2, 2
# Prime factors of  8 => 2, 2, 2
# Prime factors of 27 => 3, 3, 3

use strict;
use warnings;
use v5.28;

my $x=shift; 
for(my $y=2; $y<=$x; $y++) { 
	next if $x%$y; 
	$x/=$y; 
	say $y; 
	redo 
}
