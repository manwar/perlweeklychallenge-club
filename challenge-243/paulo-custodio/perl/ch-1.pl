#!/usr/bin/env perl

# Challenge 243
#
# Task 1: Reverse Pairs
# Submitted by: Mohammad S Anwar
#
# You are given an array of integers.
#
# Write a script to return the number of reverse pairs in the given array.
#
# A reverse pair is a pair (i, j) where: a) 0 <= i < j < nums.length and b)
# nums[i] > 2 * nums[j].
# Example 1
#
# Input: @nums = (1, 3, 2, 3, 1)
# Output: 2
#
# (1, 4) => nums[1] = 3, nums[4] = 1, 3 > 2 * 1
# (3, 4) => nums[3] = 3, nums[4] = 1, 3 > 2 * 1
#
# Example 2
#
# Input: @nums = (2, 4, 3, 5, 1)
# Output: 3
#
# (1, 4) => nums[1] = 4, nums[4] = 1, 4 > 2 * 1
# (2, 4) => nums[2] = 3, nums[4] = 1, 3 > 2 * 1
# (3, 4) => nums[3] = 5, nums[4] = 1, 5 > 2 * 1

use Modern::Perl;

@ARGV>0 or die "Usage: ch-1.pl n n ...\n";
say num_reverse_pairs(@ARGV);

sub num_reverse_pairs {
    my(@n) = @_;
    my $count = 0;
    for my $i (0..$#n-1) {
        for my $j ($i+1..$#n) {
            $count++ if $n[$i] > 2* $n[$j];
        }
    }
    return $count;
}
