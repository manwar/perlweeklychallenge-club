#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-320/#TASK2
#
# Task 2: Sum Difference
# ======================
#
# You are given an array of positive integers.
#
# Write a script to return the absolute difference between digit sum and
# element sum of the given array.
#
## Example 1
##
## Input: @ints = (1, 23, 4, 5)
## Output: 18
##
## Element sum: 1 + 23 + 4 + 5 => 33
## Digit sum: 1 + 2 + 3 + 4 + 5 => 15
## Absolute difference: | 33 - 15 | => 18
#
#
## Example 2
##
## Input: @ints = (1, 2, 3, 4, 5)
## Output: 0
##
## Element sum: 1 + 2 + 3 + 4 + 5 => 15
## Digit sum: 1 + 2 + 3 + 4 + 5 => 15
## Absolute difference: | 15 - 15 | => 0
#
#
## Example 3
##
## Input: @ints = (1, 2, 34)
## Output: 27
##
## Element sum: 1 + 2 + 34 => 37
## Digit sum: 1 + 2 + 3 + 4 => 10
## Absolute difference: | 37 - 10 | => 27
#
############################################################
##
## discussion
##
############################################################
#
# Looking at each element in the list, we just add it to the element sum.
# Then we split the element into its digits and add all of those to the
# digit sum. In the end, we calculate the absolute difference of these two
# sums for the result.

use v5.36;

sum_difference(1, 23, 4, 5);
sum_difference(1, 2, 3, 4, 5);
sum_difference(1, 2, 34);

sub sum_difference(@ints) {
    say "Input: (" . join(", ", @ints) . ")";
    my $elem_sum = 0;
    my $digit_sum = 0;
    foreach my $elem (@ints) {
        $elem_sum += $elem;
        my @digits = split //, $elem;
        foreach my $digit (@digits) {
            $digit_sum += $digit;
        }
    }
    say "Output: " . abs($elem_sum - $digit_sum);
}
