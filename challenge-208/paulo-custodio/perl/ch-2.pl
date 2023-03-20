#!/usr/bin/perl

# Challenge 208
#
# Task 2: Duplicate and Missing
# Submitted by: Mohammad S Anwar
#
# You are given an array of integers in sequence with one missing and one duplicate.
#
# Write a script to find the duplicate and missing integer in the given array.
# Return -1 if none found.
#
# For the sake of this task, let us assume the array contains no more than one
# duplicate and missing.
#
# Example 1:
#
# Input: @nums = (1,2,2,4)
# Output: (2,3)
#
# Duplicate is 2 and Missing is 3.
#
# Example 2:
#
# Input: @nums = (1,2,3,4)
# Output: -1
#
# No duplicate and missing found.
#
# Example 3:
#
# Input: @nums = (1,2,3,3)
# Output: (3,4)
#
# Duplicate is 3 and Missing is 4.

use Modern::Perl;

sub dup_and_missing {
    my(@in) = @_;
    my @dup;
    my @missing;
    my %in; $in{$_}++ for @in;
    for (1 .. @in) {
        push @dup, $_ if exists $in{$_} && $in{$_}>1;
        push @missing, $_ if !exists $in{$_};
    }
    if (@dup+@missing == 0) {
        return -1;
    }
    else {
        return (@dup, @missing);
    }
}

my @in = @ARGV;
say join(" ", dup_and_missing(@in));
