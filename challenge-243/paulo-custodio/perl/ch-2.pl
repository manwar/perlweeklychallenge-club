#!/usr/bin/env perl

# Challenge 243
#
# Task 2: Floor Sum
# Submitted by: Mohammad S Anwar
#
# You are given an array of positive integers (>=1).
#
# Write a script to return the sum of floor(nums[i] / nums[j]) where
# 0 <= i,j < nums.length. The floor() function returns the integer part of the
# division.
#
# Example 1
#
# Input: @nums = (2, 5, 9)
# Output: 10
#
# floor(2 / 5) = 0
# floor(2 / 9) = 0
# floor(5 / 9) = 0
# floor(2 / 2) = 1
# floor(5 / 5) = 1
# floor(9 / 9) = 1
# floor(5 / 2) = 2
# floor(9 / 2) = 4
# floor(9 / 5) = 1
#
# Example 2
#
# Input: @nums = (7, 7, 7, 7, 7, 7, 7)
# Output: 49

use Modern::Perl;

@ARGV>0 or die "Usage: ch-2.pl n n ...\n";
say sum_floor(@ARGV);

sub sum_floor {
    my(@n) = @_;
    my $sum = 0;
    for my $i (0..$#n) {
        for my $j (0..$#n) {
            $sum += int($n[$i] / $n[$j]);
        }
    }
    return $sum;
}
