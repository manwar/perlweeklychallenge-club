#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-381/#TASK2
#
# Task 2: Smaller Greater Element
# ===============================
#
# You are given an array of integers.
#
# Write a script to find the number of elements that have both a strictly
# smaller and greater element in the given array.
#
## Example 1
##
## Input: @int = (2,4)
## Output: 0
##
## Not enough elements in the array.
#
## Example 2
##
## Input: @int = (1, 1, 1, 1)
## Output: 0
#
## Example 3
##
## Input: @int = (1, 1, 4, 8, 12, 12)
## Output: 2
##
## The elements are 4 and 8.
#
## Example 4
##
## Input: @int = (3, 6, 6, 9)
## Output: 2
##
## Both instances of 6.
#
## Example 5
##
## Input: @int = (0, -5, 10, -2, 4)
## Output: 3
##
## The elements are 0, -2, and 4.
#
############################################################
##
## discussion
##
############################################################
#
# We just find the min and max values in the array, then we count
# all elements that are bigger than the min and smaller than the max.

use v5.36;
use List::Util qw(min max);

smaller_greater_element(2,4);
smaller_greater_element(1, 1, 1, 1);
smaller_greater_element(1, 1, 4, 8, 12, 12);
smaller_greater_element(3, 6, 6, 9);
smaller_greater_element(0, -5, 10, -2, 4);

sub smaller_greater_element(@int) {
    say "Input: (" . join(", ", @int) . ")";
    my $count = 0;
    my $min = min(@int);
    my $max = max(@int);
    foreach my $elem (@int) {
        if($elem > $min && $elem < $max) {
            $count++;
        }
    }
    say "Output: $count";
}
