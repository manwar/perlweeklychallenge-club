#!/usr/bin/perl

# Challenge 204
#
# Task 1: Monotonic Array
# Submitted by: Mohammad S Anwar
# 
# You are given an array of integers.
# 
# Write a script to find out if the given array is Monotonic. Print 1 if it is otherwise 0.
# 
#     An array is Monotonic if it is either monotone increasing or decreasing.
# 
# Monotone increasing: for i <= j , nums[i] <= nums[j]
# Monotone decreasing: for i <= j , nums[i] >= nums[j]
# 
# 
# Example 1
# 
# Input: @nums = (1,2,2,3)
# Output: 1
# 
# Example 2
# 
# Input: @nums = (1,3,2)
# Output: 0
# 
# Example 3
# 
# Input: @nums = (6,5,5,4)
# Output: 1

use Modern::Perl;

sub is_monotonic {
	my(@list) = @_;
	return 1 if @list < 2;
	my $climb = 0;
	my $descend = 0;
	for my $i (0..$#list-1) {
		my $delta = $list[$i+1]-$list[$i];
		if ($delta > 0) { $climb++; }
		elsif ($delta < 0) { $descend++; }
		if ($climb && $descend) { return 0; }
	}
	return 1;	
}

say is_monotonic(@ARGV);
