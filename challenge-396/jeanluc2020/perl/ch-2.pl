#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-396/#TASK2
#
# Task 2: Trionic Array
# =====================
#
# You are given an array of integer.
#
# Write a script to return true if the given array is Trionic otherwise return
# false.
#
## An array is trionic if there exist indices 0 < p < q < n − 1 such that
## arr[0…p] is strictly increasing, arr[p…q] is strictly decreasing, and
## arr[q…n − 1] is strictly increasing.
#
## Example 1
##
## Input: @arr = (1, 3, 5, 4, 2, 6, 8)
## Output: true
##
## Choose p = 2 and q = 4
## $arr[0..2] = (1, 3, 5) (strictly increasing)
## $arr[2..4] = (5, 4, 2) (strictly decreasing)
## $arr[4..6] = (2, 6, 8) (strictly increasing)
##
## Valid indices: 0 < p (2) < q (4) < n-1 (6).
#
## Example 2
##
## Input: @arr = (1, 4, 4, 2, 1, 3, 5)
## Output: false
##
## The first segment (1, 4, 4) contains duplicate adjacent values, so it is not
## strictly increasing.
## No valid p and q exist to satisfy all three strictly monotonic conditions.
#
## Example 3
##
## Input: @arr = (2, 10, 3, 1, 9)
## Output: true
##
## Choose p = 1 and q = 3.
## $arr[0..1] = (2, 10)    (strictly increasing)
## $arr[1..3] = (10, 3, 1) (strictly decreasing)
## $arr[3..4] = (1, 9)     (strictly increasing)
#
## Example 4
##
## Input: @arr = (1, 2, 3, 4, 3, 2, 1)
## Output: false
##
## This is a standard mountain array (strictly increasing, then strictly
## decreasing).
## There is no second valley (q) that transitions back into a strictly
## increasing third segment before reaching the end of the array.
#
## Example 5
##
## Input: @arr = (1, 3, 6, 4, 2, 7, 8, 4)
## Output: false
#
############################################################
##
## discussion
##
############################################################
#
# Keeping state of whether we are in the first increasing, the
# decreasing or the second increasing part, we move through the
# array, bailing out on all error conditions that we meet. In
# the end, we return true only if our state indicates we are in
# the second increasing state.

use v5.36;

sub trionic_array(@arr) {
    say "Input: (" . join(", ", @arr) . ")";
    my $trio = 0;
    foreach my $i (0..$#arr-1) {
        if($trio == 0) {
            next if $arr[$i+1] > $arr[$i];
            # if we don't strictly increase at the first position, then
            # we can bail out in error
            return say "Output: false" if $i == 0;
            # if we're not strictly in/decreasing, then we can bail
            # out as well
            return say "Output: false" if $arr[$i+1] == $arr[$i];
            # Now we're strictly decreasing
            $trio = 1;
        } elsif ($trio == 1) {
            next if $arr[$i+1] < $arr[$i];
            # if we're not strictly in/decreasing, then we can bail out
            return say "Output: false" if $arr[$i+1] == $arr[$i];
            # now we're strictly increasing again
            $trio = 2;
        } else {
            next if $arr[$i+1] > $arr[$i];
            # if we're not strictly increasing, then we can bail out
            return say "Output: false";
        }
    }
    return say "Output: true" if $trio == 2;
    say "Output: false";
}

trionic_array(1, 3, 5, 4, 2, 6, 8);
trionic_array(1, 4, 4, 2, 1, 3, 5);
trionic_array(2, 10, 3, 1, 9);
trionic_array(1, 2, 3, 4, 3, 2, 1);
trionic_array(1, 3, 6, 4, 2, 7, 8, 4);
