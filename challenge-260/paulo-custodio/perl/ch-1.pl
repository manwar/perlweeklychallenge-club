#!/usr/bin/env perl

# Challenge 260
#
# Task 1: Unique Occurrences
# Submitted by: Mohammad Sajid Anwar
#
# You are given an array of integers, @ints.
#
# Write a script to return 1 if the number of occurrences of each value in the
# given array is unique or 0 otherwise.
# Example 1
#
# Input: @ints = (1,2,2,1,1,3)
# Output: 1
#
# The number 1 occurred 3 times.
# The number 2 occurred 2 times.
# The number 3 occurred 1 time.
#
# All occurrences are unique, therefore the output is 1.
#
# Example 2
#
# Input: @ints = (1,2,3)
# Output: 0
#
# Example 3
#
# Input: @ints = (-2,0,1,-2,1,1,0,1,-2,9)
# Output: 1

use Modern::Perl;

my @ints = @ARGV;
say uniq_occurences(@ints);

sub uniq_occurences {
    my(@ints) = @_;
    my %count;
    $count{$_}++ for @ints;
    my %uniq;
    for (values %count) {
        return 0 if $uniq{$_}++;
    }
    return 1;
}
