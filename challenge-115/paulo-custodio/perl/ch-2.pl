#!/usr/bin/env perl

# Challenge 115
# 
# TASK #2 - Largest Multiple
# Submitted by: Mohammad S Anwar
# You are given a list of positive integers (0-9), single digit.
# 
# Write a script to find the largest multiple of 2 that can be formed from the
# list.
# 
# Examples
# Input: @N = (1, 0, 2, 6)
# Output: 6210
# 
# Input: @N = (1, 4, 2, 8)
# Output: 8412
# 
# Input: @N = (4, 1, 7, 6)
# Output: 7614

use Modern::Perl;

my @nums = @ARGV;
@nums or die "Usage: ch-1.pl words...\n";
say largest_mult2(@nums);

sub largest_mult2 {
	my(@nums) = @_;
	
	# select smallest even number for last element
	my @even = sort {$a->[1] <=> $b->[1]} 
			   grep {$_->[1] % 2 == 0} 
			   map {[$_, $nums[$_]]} 0..$#nums;
	return 0 if !@even;			# no even numbers
	my($index, $last) = @{$even[0]};
	splice(@nums, $index, 1);		# remove it from @nums
	
	# sort the other elements in descending order
	@nums = sort {$b <=> $a} @nums;
	
	return 0+join('',@nums,$last);
}
