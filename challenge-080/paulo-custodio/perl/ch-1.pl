#!/usr/bin/perl

# Challenge 081
#
# TASK #1 › Smallest Positive Number
# Submitted by: Mohammad S Anwar
# You are given unsorted list of integers @N.
#
# Write a script to find out the smallest positive number missing.
#
# Example 1:
# Input: @N = (5, 2, -2, 0)
# Output: 1
# Example 2:
# Input: @N = (1, 8, -1)
# Output: 2
# Example 3:
# Input: @N = (2, 0, -1)
# Output: 1

use strict;
use warnings;
use 5.030;

say missing(@ARGV);


sub missing {
    my @N = sort grep {$_ > 0} @_;  # filter only positive numbers and sort
    for (0 .. $#N) {                # find missing sequence
        return $_+1 if $N[$_] != $_+1;
    }
    return scalar(@N)+1;
}
