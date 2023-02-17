#!/usr/bin/env perl

# Task 1: Monotonic Array
# Submitted by: Mohammad S Anwar
# 
# You are given an array of integers.
# Write a script to find out if the given array is Monotonic. Print 1 if it is otherwise 0.
# 
#     An array is Monotonic if it is either monotone increasing or decreasing.
# 
# Monotone increasing: for i <= j , nums[i] <= nums[j]
# Monotone decreasing: for i <= j , nums[i] >= nums[j]
# 
# Example 1
# Input: @nums = (1,2,2,3)
# Output: 1
# 
# Example 2
# Input: @nums (1,3,2)
# Output: 0
# 
# Example 3
# Input: @nums = (6,5,5,4)
# Output: 1


use strict;
use warnings;

my @input = @ARGV;
die "Input error\n"
    if scalar @input < 2
       or
       (scalar map { $_ =~ /^\d+$/ ? () : 1 }
                @input) != 0;

my $monotone_inc = 1;
my $monotone_dec = 1;
foreach my $i (1..$#input) {
    if ($monotone_inc) {
        $monotone_inc = 0
            if $input[$i] < $input[$i-1];
    }
    if ($monotone_dec) {
        $monotone_dec = 0
            if $input[$i] > $input[$i-1];
    }
    last
        if !$monotone_inc and !$monotone_dec;
}

printf "%d\n", ($monotone_inc or $monotone_dec)
    ? 1
    : 0;
