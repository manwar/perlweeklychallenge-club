#!/usr/bin/env perl

# Challenge 351
#
# Task 1: Special Average
# Submitted by: Mohammad Sajid Anwar
# You are given an array of integers.
#
# Write a script to return the average excluding the minimum and maximum of the given array.
#
# Example 1
# Input: @ints = (8000, 5000, 6000, 2000, 3000, 7000)
# Output: 5250
#
# Min: 2000
# Max: 8000
# Avg: (3000+5000+6000+7000)/4 = 21000/4 = 5250
#
# Example 2
# Input: @ints = (100_000, 80_000, 110_000, 90_000)
# Output: 95_000
#
# Min: 80_000
# Max: 110_000
# Avg: (100_000 + 90_000)/2 = 190_000/2 = 95_000
#
# Example 3
# Input: @ints = (2500, 2500, 2500, 2500)
# Output: 0
#
# Min: 2500
# Max: 2500
# Avg: 0
#
# Example 4
# Input: @ints = (2000)
# Output: 0
#
# Min: 2000
# Max: 2000
# Avg: 0
#
# Example 5
# Input: @ints = (1000, 2000, 3000, 4000, 5000, 6000)
# Output: 3500
#
# Min: 1000
# Max: 6000
# Avg: (2000 + 3000 + 4000 + 5000)/4 = 14000/4 = 3500

use Modern::Perl;

@ARGV or die "usage: $0 nums...\n";

say special_average(@ARGV);

sub special_average {
    my(@nums) = @_;
    return 0 if @nums==0;
    @nums = sort {$a<=>$b} @nums;
    @nums = grep {$_ != $nums[0] && $_ != $nums[-1]} @nums;
    return 0 if @nums==0;
    return $nums[0] if @nums==1;
    my $sum; $sum += $_ for @nums;
    return $sum / scalar(@nums);
}
