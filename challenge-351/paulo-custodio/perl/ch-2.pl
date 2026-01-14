#!/usr/bin/env perl

# Challenge 351
#
# Task 2: Arithmetic Progression
# Submitted by: Mohammad Sajid Anwar
# You are given an array of numbers.
#
# Write a script to return true if the given array can be re-arranged to form an arithmetic progression, otherwise return false.
#
# A sequence of numbers is called an arithmetic progression if the difference between any two consecutive elements is the same.
#
#
# Example 1
# Input: @num = (1, 3, 5, 7, 9)
# Output: true
#
# Already AP with common difference 2.
#
# Example 2
# Input: @num = (9, 1, 7, 5, 3)
# Output: true
#
# The given array re-arranged like (1, 3, 5, 7, 9) with common difference 2.
#
# Example 3
# Input: @num = (1, 2, 4, 8, 16)
# Output: false
#
# This is geometric progression and not arithmetic progression.
#
# Example 4
# Input: @num = (5, -1, 3, 1, -3)
# Output: true
#
# The given array re-arranged like (-3, -1, 1, 3, 5) with common difference 2.
#
# Example 5
# Input: @num = (1.5, 3, 0, 4.5, 6)
# Output: true
#
# The given array re-arranged like (0, 1.5, 3, 4.5, 6) with common difference 1.5.

use Modern::Perl;

@ARGV or die "usage: $0 nums...\n";

say is_ap(@ARGV) ? 'true' : 'false';

sub is_ap {
    my(@nums) = @_;
    return if @nums < 3;
    @nums = sort {$a<=>$b} @nums;
    my $delta = $nums[1] - $nums[0];
    for my $i (1 .. $#nums - 1) {
        return if $nums[$i+1] - $nums[$i] != $delta;
    }
    return 1;
}
