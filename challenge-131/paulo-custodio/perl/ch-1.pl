#!/usr/bin/env perl

# TASK #1 > Consecutive Arrays
# Submitted by: Mark Anderson
# You are given a sorted list of unique positive integers.
# 
# Write a script to return list of arrays where the arrays are consecutive
# integers.
# 
# Example 1:
# Input:  (1, 2, 3, 6, 7, 8, 9)
# Output: ([1, 2, 3], [6, 7, 8, 9])
# Example 2:
# Input:  (11, 12, 14, 17, 18, 19)
# Output: ([11, 12], [14], [17, 18, 19])
# Example 3:
# Input:  (2, 4, 6, 8)
# Output: ([2], [4], [6], [8])
# Example 4:
# Input:  (1, 2, 3, 4, 5)
# Output: ([1, 2, 3, 4, 5])

use Modern::Perl;
use Data::Dump 'dump';

my @input = @ARGV;
my @output = cons_arrays(@input);
say "[".join(", ", map {"[".join(", ", @$_)."]"} @output)."]";

sub cons_arrays {
	my(@input) = @_;
	my @output = [shift @input];
	while (@input) {
		my $n = shift @input;
		if ($n == $output[-1][-1] + 1) {
			push @{$output[-1]}, $n;
		}
		else {
			push @output, [$n];
		}
	}
	return @output;
}
