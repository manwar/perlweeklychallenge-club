#!/usr/bin/env perl

# Task 2: Duplicate and Missing
# Submitted by: Mohammad S Anwar
# 
# You are given an array of integers in sequence with one missing and one duplicate.
# Write a script to find the duplicate and missing integer in the given array. Return -1 if none found.
# For the sake of this task, let us assume the array contains no more than one duplicate and missing.
# 
# Example 1:
# Input: @nums = (1,2,2,4)
# Output: (2,3)
# Duplicate is 2 and Missing is 3.
# 
# Example 2:
# Input: @nums = (1,2,3,4)
# Output: -1
# No duplicate and missing found.
# 
# Example 3:
# Input: @nums = (1,2,3,3)
# Output: (3,4)
# Duplicate is 3 and Missing is 4.

use strict;
use warnings;
use feature 'say';

say duplicate_and_missing([1,2,2,4]);
say duplicate_and_missing([1,2,3,4]);
say duplicate_and_missing([1,2,3,3]);

exit 0;

sub duplicate_and_missing {
    my $list = shift;

    my @duplicate_or_missing;
    foreach my $i (0..(scalar @$list)-1) {
        if (scalar(grep /^$list->[$i]$/, @$list) > 1) {
            push @duplicate_or_missing, $list->[$i];
            last;
        }
    }
    foreach my $i (0..(scalar @$list)-1) {
        my $value = $i+$list->[0];
        push @duplicate_or_missing, $value
            unless grep /^$value$/, @$list;
    }
    return (@duplicate_or_missing)
        ? sprintf "(%s)", join ', ', @duplicate_or_missing
        : sprintf '-1';
}
