#!/usr/bin/env perl

# TASK #1 > JortSort
# Submitted by: Mohammad S Anwar
# You are given a list of numbers.
#
# Write a script to implement JortSort. It should return true/false depending
# if the given list of numbers are already sorted.
#
# Example 1:
# Input: @n = (1,2,3,4,5)
# Output: 1
#
# Since the array is sorted, it prints 1.
# Example 2:
# Input: @n = (1,3,2,4,5)
# Output: 0
#
# Since the array is NOT sorted, it prints 0.

use Modern::Perl;

sub jortsort {
    my(@nums) = @_;
    my @sorted = sort {$a<=>$b} @nums;
    for (0..$#nums) {
        return 0 if $nums[$_]!=$sorted[$_];
    }
    return 1;
}

say jortsort(@ARGV);
