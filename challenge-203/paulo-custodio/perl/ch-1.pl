#!/usr/bin/perl

# Challenge 203
#
# Task 1: Special Quadruplets
# Submitted by: Mohammad S Anwar
#
# You are given an array of integers.
#
# Write a script to find out the total special quadruplets for the given array.
#
# Special Quadruplets are such that satisfies the following 2 rules.
# 1) nums[a] + nums[b] + nums[c] == nums[d]
# 2) a < b < c < d
#
#
# Example 1
#
# Input: @nums = (1,2,3,6)
# Output: 1
#
# Since the only special quadruplets found is
# $nums[0] + $nums[1] + $nums[2] == $nums[3].
#
# Example 2
#
# Input: @nums = (1,1,1,3,5)
# Output: 4
#
# $nums[0] + $nums[1] + $nums[2] == $nums[3]
# $nums[0] + $nums[1] + $nums[3] == $nums[4]
# $nums[0] + $nums[2] + $nums[3] == $nums[4]
# $nums[1] + $nums[2] + $nums[3] == $nums[4]
#
# Example 3
#
# Input: @nums = (3,3,6,4,5)
# Output: 0

use Modern::Perl;

sub num_quadruplets {
    my(@nums) = @_;
    my $count = 0;
    for my $a (0..$#nums-3) {
        for my $b ($a+1..$#nums-2) {
            for my $c ($b+1..$#nums-1) {
                for my $d ($c+1..$#nums) {
                    if ($nums[$a]+$nums[$b]+$nums[$c]==$nums[$d]) {
                        $count++;
                    }
                }
            }
        }
    }
    return $count;
}

say num_quadruplets(@ARGV);
