#!/usr/bin/env perl

# Task 2: Multiply by Two
# Submitted by: Mohammad Sajid Anwar
# 
# You are given an array of integers, @ints and an integer $start..
# Write a script to do the followings:
# 
# a) Look for $start in the array @ints, if found multiply the number by 2
# b) If not found stop the process otherwise repeat
# 
# In the end return the final value.
# 
# Example 1
# Input: @ints = (5,3,6,1,12) and $start = 3
# Output: 24
# 
# Step 1: 3 is in the array so 3 x 2 = 6
# Step 2: 6 is in the array so 6 x 2 = 12
# Step 3: 12 is in the array so 12 x 2 = 24
# 
# 24 is not found in the array so return 24.
# 
# Example 2
# Input: @ints = (1,2,4,3) and $start = 1
# Output: 8
# 
# Step 1: 1 is in the array so 1 x 2 = 2
# Step 2: 2 is in the array so 2 x 2 = 4
# Step 3: 4 is in the array so 4 x 2 = 8
# 
# 8 is not found in the array so return 8.
# 
# Example 3
# Input: @ints = (5,6,7) and $start = 2
# Output: 2
# 
# 2 is not found in the array so return 2.

use strict;
use warnings;

my @ints = (5,3,6,1,12);
my $start = 3;
multiply_by_two($start, \@ints);

@ints = (1,2,4,3);
$start = 1;
multiply_by_two($start, \@ints);

@ints = (5,6,7);
$start = 2;
multiply_by_two($start, \@ints);

exit 0;

sub multiply_by_two {
    my $start = shift;
    my $ints = shift;

    my $curr = $start;
    while (grep /^$curr$/, @$ints) {
        $curr *= 2;
    }
    
    printf "start %d (%s) -> %s\n",
        $start,
        (join ',', @$ints),
        $curr;

    return undef;
}
