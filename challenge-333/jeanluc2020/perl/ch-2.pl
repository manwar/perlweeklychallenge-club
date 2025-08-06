#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-333/#TASK2
#
# Task 2: Duplicate Zeros
# =======================
#
# You are given an array of integers.
#
# Write a script to duplicate each occurrence of zero, shifting the remaining
# elements to the right. The elements beyond the length of the original array
# are not written.
#
## Example 1
##
## Input: @ints = (1, 0, 2, 3, 0, 4, 5, 0)
## Output: (1, 0, 0, 2, 3, 0, 0, 4)
##
## Each zero is duplicated.
## Elements beyond the original length (like 5 and last 0) are discarded.
#
#
## Example 2
##
## Input: @ints = (1, 2, 3)
## Output: (1, 2, 3)
##
## No zeros exist, so the array remains unchanged.
#
#
## Example 3
##
## Input: @ints = (1, 2, 3, 0)
## Output: (1, 2, 3, 0)
#
#
## Example 4
##
## Input: @ints = (0, 0, 1, 2)
## Output: (0, 0, 0, 0)
#
#
## Example 5
##
## Input: @ints = (1, 2, 0, 3, 4)
## Output: (1, 2, 0, 0, 3)
#
############################################################
##
## discussion
##
############################################################
#
# We just walk from the left of the array to the right. Whenever
# we see a "0", we replace the rest of the array by a zero followed
# by the rest minus the last element. Of course then we need to skip
# the check for "0" in the next iteration so we keep state in a
# variable $skip.

use v5.36;

duplicate_zeros(1, 0, 2, 3, 0, 4, 5, 0);
duplicate_zeros(1, 2, 3);
duplicate_zeros(1, 2, 3, 0);
duplicate_zeros(0, 0, 1, 2);
duplicate_zeros(1, 2, 0, 3, 4);

sub duplicate_zeros(@ints) {
    say "Input: (" . join(", ", @ints) . ")";
    my $skip = 0;
    foreach my $i (0..$#ints-1) {
        if($skip) {
            $skip = 0;
            next;
        }
        if($ints[$i] == 0) {
            @ints[$i+1..$#ints] = (0, @ints[$i+1..$#ints-1]);
            $skip = 1;
        }
    }
    say "Output: (" . join(", ", @ints) . ")";
}
