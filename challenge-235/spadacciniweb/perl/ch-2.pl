#!/usr/bin/env perl

# Task 2: Duplicate Zeros
# Submitted by: Mohammad S Anwar
# 
# You are given an array of integers.
# Write a script to duplicate each occurrence of ZERO in the given array and shift the remaining to the right but make sure the size of array remain the same.
#
# Example 1
# 
# Input: @ints = (1, 0, 2, 3, 0, 4, 5, 0)
# Ouput: (1, 0, 0, 2, 3, 0, 0, 4)
# 
# Example 2
# Input: @ints = (1, 2, 3)
# Ouput: (1, 2, 3)
# 
# Example 3
# 
# Input: @ints = (0, 3, 0, 4, 5)
# Ouput: (0, 0, 3, 0, 0)


use strict;
use warnings;

my @input = @ARGV;
die "Input error\n"
    if scalar @input < 1
       or
       (scalar map { $_ =~ /[\-\d]/ ? () : 1 }
                 @input) != 0;

printf "(%s)\n", join ', ', (map { $_ == 0 ? (0, 0) : $_ }
                             @input)[0..$#input];
