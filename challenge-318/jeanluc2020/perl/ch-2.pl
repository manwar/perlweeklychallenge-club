#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-318/#TASK2
#
# Task 2: Reverse Equals
# ======================
#
# You are given two arrays of integers, each containing the same elements as
# the other.
#
# Write a script to return true if one array can be made to equal the other by
# reversing exactly one contiguous subarray.
#
## Example 1
##
## Input: @source = (3, 2, 1, 4)
##        @target = (1, 2, 3, 4)
## Output: true
##
## Reverse elements: 0-2
#
#
## Example 2
##
## Input: @source = (1, 3, 4)
##        @target = (4, 1, 3)
## Output: false
#
#
## Example 3
##
## Input: @source = (2)
##        @target = (2)
## Output: true
#
############################################################
##
## discussion
##
############################################################
#
# We let two variables walk the indices in the array, starting at
# 0 and going up to the index of the last element. Then we cut the
# source array into 3 parts:
# - a slice from the start to $i - 1
# - a slice from $i to $j
# - a slice from $j + 1 until the index of the last element
# Then we put all of these parts together, reversing the second of these
# subarrays. If the temporary array is the same as @target we found
# a solution, so we can return true. If in the end, we didn't find a
# solution, we need to return false.
#

use v5.36;

reverse_equals( [3, 2, 1, 4], [1, 2, 3, 4] );
reverse_equals( [1, 3, 4], [4, 1, 3] );
reverse_equals( [2], [2] );

sub reverse_equals( $source, $target ) {
    my @source = @$source;
    my @target = @$target;
    say "Input: (" . join(", ", @source) . "), (" . join(", ", @target) . ")";
    return say "Output: false" unless scalar(@source) == scalar(@target);
    foreach my $i (0..$#source) {
        foreach my $j ($i..$#source) {
            my @tmp = @source[0..$i-1];
            push @tmp, reverse @source[$i..$j];
            push @tmp,  @source[$j+1..$#source];
            my $matching = 1;
            foreach my $k (0..$#tmp) {
                if($tmp[$k] != $target[$k]) {
                    $matching = 0;
                }
            }
            return say "Output: true" if $matching;
        }
    }
    say "Output: false";
}
