#!/usr/bin/perl

# Challenge 189
#
# Task 2: Array Degree
# Submitted by: Mohammad S Anwar
#
# You are given an array of 2 or more non-negative integers.
#
# Write a script to find out the smallest slice, i.e. contiguous subarray
# of the original array, having the degree of the given array.
#
#     The degree of an array is the maximum frequency of an element in the array.
#
# Example 1
#
# Input: @array = (1, 3, 3, 2)
# Output: (3, 3)
#
# The degree of the given array is 2.
# The possible subarrays having the degree 2 are as below:
# (3, 3)
# (1, 3, 3)
# (3, 3, 2)
# (1, 3, 3, 2)
#
# And the smallest of all is (3, 3).
#
# Example 2
#
# Input: @array = (1, 2, 1, 3)
# Output: (1, 2, 1)
#
# Example 3
#
# Input: @array = (1, 3, 2, 1, 2)
# Output: (2, 1, 2)
#
# Example 4
#
# Input: @array = (1, 1, 2, 3, 2)
# Output: (1, 1)
#
# Example 5
#
# Input: @array = (2, 1, 2, 1, 1)
# Output: (1, 2, 1, 1)

use Modern::Perl;

sub degree {
    my(@n)=@_;
    my @freq; $freq[$_]++ for @n;
    @freq=sort {$b<=>$a} @freq;
    return $freq[0];
}

sub smallest_slice {
    my(@n)=@_;
    my $degree=degree(@n);
    my @smallest_slice=@n;
    for my $i (0..$#n-1) {
        for my $j ($i+1..$#n) {
            my @slice=@n[$i..$j];
            if (degree(@slice)==$degree && @slice<@smallest_slice) {
                @smallest_slice=@slice;
            }
        }
    }
    return @smallest_slice;
}

@ARGV>=2 or die "usage: ch-2.pl nums...\n";
say "(",join(", ", smallest_slice(@ARGV)),")";
