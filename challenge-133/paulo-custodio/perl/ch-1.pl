#!/usr/bin/env perl

# TASK #1 > Integer Square Root
# Submitted by: Mohammad S Anwar
# You are given a positive integer $N.
# 
# Write a script to calculate the integer square root of the given number.
# 
# Please avoid using built-in function. Find out more about it here.
# 
# Examples
# Input: $N = 10
# Output: 3
# 
# Input: $N = 27
# Output: 5
# 
# Input: $N = 85
# Output: 9
# 
# Input: $N = 101
# Output: 10

# solution: https://en.wikipedia.org/wiki/Integer_square_root

use Modern::Perl;
my $n = shift || 0;
say isqrt($n);

sub isqrt {
	my($n) = @_;
	my $x0 = $n >> 1;		# initial estimate
	return $n if $x0 == 0;
	
	# loop
	my $x1 = ($x0 + $n/$x0) >> 1;
	while ($x1 < $x0) {
		$x0 = $x1;
		$x1 = ($x0 + $n/$x0) >> 1;
	}
	return $x0;
}
