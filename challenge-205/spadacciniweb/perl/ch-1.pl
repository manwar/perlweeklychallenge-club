#!/usr/bin/env perl

# Task 1: Third Highest
# Submitted by: Mohammad S Anwar
# 
# You are given an array of integers.
# Write a script to find out the Third Highest if found otherwise return the maximum.
#
# Example 1
# Input: @array = (5,3,4)
# Output: 3
# 
# First highest is 5. Second highest is 4. Third highest is 3.
# 
# Example 2
# Input: @array = (5,6)
# Output: 6
# 
# First highest is 6. Second highest is 5. Third highest is missing, so maximum is returned.
# 
# Example 3
# Input: @array = (5,4,4,3)
# Output: 3
# 
# First highest is 5. Second highest is 4. Third highest is 3.

use strict;
use warnings;
use List::MoreUtils qw(uniq);

my @input = @ARGV;
die "Input error\n"
    if scalar @input < 1
       or
       (scalar map { $_ =~ /^\d+$/ ? () : 1 }
                @input) != 0;

@input = map { $_ } sort { $b <=> $a } uniq @input;
printf "Output: %s", $input[ (scalar @input >= 3) ? 2 : 0 ];
