#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-355/#TASK2
#
# Task 2: Mountain Array
# ======================
#
# You are given an array of integers, @ints.
#
# Write a script to return true if the given array is a valid mountain array.
#
# An array is mountain if and only if:
## 1) arr.length >= 3
## and
## 2) There exists some i with 0 < i < arr.length - 1 such that:
## arr[0] < arr[1]     < ... < arr[i - 1] < arr[i]
## arr[i] > arr[i + 1] > ... > arr[arr.length - 1]
#
## Example 1
##
## Input: @ints = (1, 2, 3, 4, 5)
## Output: false
#
#
## Example 2
##
## Input: @ints = (0, 2, 4, 6, 4, 2, 0)
## Output: true
#
#
## Example 3
##
## Input: @ints = (5, 4, 3, 2, 1)
## Output: false
#
#
## Example 4
##
## Input: @ints = (1, 3, 5, 5, 4, 2)
## Output: false
#
#
## Example 5
##
## Input: @ints = (1, 3, 2)
## Output: true
#
############################################################
##
## discussion
##
############################################################
#
# First, we check a few necessary cases (>= 3 elements in the array,
# first element of the array is smaller than second element). Then,
# we walk the array from beginning to end, keeping track of whether
# we're still in the ascending phase or already descending. In the
# former case we need to bail out if two elements are exactly the same,
# in the latter case we need to bail out if the first element is smaller
# than the second one. In the end, we just need to exit if we find the
# biggest number at the end of the array. In the ascending phase we
# also need to check whether two elements are the same and return false
# if that's the case. We also need to switch to the descending phase
# once a number is smaller than its predecessor in the array while
# we're still in the ascending phase.
#
use v5.36;

mountain_array(1, 2, 3, 4, 5);
mountain_array(0, 2, 4, 6, 4, 2, 0);
mountain_array(5, 4, 3, 2, 1);
mountain_array(1, 3, 5, 5, 4, 2);
mountain_array(1, 3, 2);

sub mountain_array(@ints) {
    say "Input: (" . join(", ", @ints) . ")";
    return say "Output: false" unless scalar(@ints) >= 3;
    return say "Output: false" unless $ints[0] < $ints[1];
    my $going_up = 1;
    foreach my $i (1..$#ints-1) {
        if($going_up) {
            return say "Output: false" if $ints[$i] == $ints[$i+1];
            $going_up = 0 if $ints[$i] > $ints[$i+1];
        } else {
            return say "Output: false" unless $ints[$i] > $ints[$i+1];
        }
    }
    say "Output: false" if $going_up;
    say "Output: true";
}

