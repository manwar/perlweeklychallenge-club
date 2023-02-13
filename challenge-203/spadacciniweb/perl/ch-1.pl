#!/usr/bin/env perl

# Task 1: Special Quadruplets
# Submitted by: Mohammad S Anwar
# 
# You are given an array of integers.
# Write a script to find out the total special quadruplets for the given array.
# 
# Special Quadruplets are such that satisfies the following 2 rules.
# 1) nums[a] + nums[b] + nums[c] == nums[d]
# 2) a < b < c < d
# 
# 
# Example 1
# Input: @nums = (1,2,3,6)
# Output: 1
# 
# Since the only special quadruplets found is $nums[0] + $nums[1] + $nums[2] == $nums[3].
# 
# Example 2
# Input: @nums = (1,1,1,3,5)
# Output: 4
# 
# $nums[0] + $nums[1] + $nums[2] == $nums[3]
# $nums[0] + $nums[1] + $nums[3] == $nums[4]
# $nums[0] + $nums[2] + $nums[3] == $nums[4]
# $nums[1] + $nums[2] + $nums[3] == $nums[4]
# 
# Example 3
# Input: @nums = (3,3,6,4,5)
# Output: 0

use strict;
use warnings;

my @input = @ARGV;
die "Input error\n"
    if scalar @input < 4
       or
       (scalar map { $_ =~ /^\d+$/ ? () : 1 }
                @input) != 0;

my @quadruplets = ();
foreach my $i (0..$#input-3) {
    foreach my $j ($i+1..$#input-2) {
        foreach my $k ($j+1..$#input-1) {
            foreach my $z ($k+1..$#input) {
                push @quadruplets, [$i, $j, $k, $z]
                    if $input[$i] + $input[$j] + $input[$k] == $input[$z];
            }
        }
    }
}

print scalar @quadruplets, "\n"
