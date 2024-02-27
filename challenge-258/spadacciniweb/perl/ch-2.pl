#!/usr/bin/env perl

# Task 2: Sum of Values
# Submitted by: Mohammad Sajid Anwar
# 
# You are given an array of integers, @int and an integer $k.
# 
# Write a script to find the sum of values whose index binary representation has exactly $k number of 1-bit set.
# 
# Example 1
# Input: @ints = (2, 5, 9, 11, 3), $k = 1
# Output: 17
# 
# Binary representation of index 0 = 0
# Binary representation of index 1 = 1
# Binary representation of index 2 = 10
# Binary representation of index 3 = 11
# Binary representation of index 4 = 100
# 
# So the indices 1, 2 and 4 have total one 1-bit sets.
# Therefore the sum, $ints[1] + $ints[2] + $ints[3] = 17
# 
# Example 2
# Input: @ints = (2, 5, 9, 11, 3), $k = 2
# Output: 11
# 
# Example 3
# Input: @ints = (2, 5, 9, 11, 3), $k = 0
# Output: 2

use strict;
use warnings;
use List::Util qw/ sum /;

my @ints = (2, 5, 9, 11, 3); my $k = 1;
sum_of_values(\@ints, $k);

@ints = (2, 5, 9, 11, 3); $k = 2;
sum_of_values(\@ints, $k);

@ints = (2, 5, 9, 11, 3); $k = 0;
sum_of_values(\@ints, $k);

exit 0;

sub sum_of_values {
    my $ints = shift || [];
    my $k = shift || 0;

    my @indexes = map { ( (scalar grep { /1/ }
                                 split //, sprintf ("%b", $_) ) == $k )
                            ? $_
                            : ()
                  } 0..(scalar @$ints)-1;
    printf "(%s) %d -> %s\n",
        (join ', ', @$ints ), $k,
        sum @ints[@indexes];

    return undef;
}
