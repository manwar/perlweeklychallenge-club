#!/usr/bin/env perl

# Task 2: Floor Sum
# 
# You are given an array of positive integers (>=1).
# 
# Write a script to return the sum of floor(nums[i] / nums[j]) where 0 <= i,j < nums.length. The floor() function returns the integer part of the division.
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

use strict;
use warnings;
use v5.28;
use Data::Dump qw(dump);

my @examples = (
    [ 2, 5, 9 ],
    [ 7, 7, 7, 7, 7, 7, 7 ],
);

sub sum_of_floor {
    my $nums = shift;
    my $sum = 0;

    foreach my $i (@$nums) {
        $sum += int($i / $_) foreach (@$nums)
    }

    return $sum
}

for my $elements (@examples) {
    my $sof = sum_of_floor($elements);

    say 'Input : @nums = ', dump(@$elements);
    say 'Output : ', $sof;
}
