#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-339/#TASK1
#
# Task 1: Max Diff
# ================
#
# You are given an array of integers having four or more elements.
#
# Write a script to find two pairs of numbers from this list (four numbers
# total) so that the difference between their products is as large as possible.
#
# In the end return the max difference.
#
## With Two pairs (a, b) and (c, d), the product difference is (a * b) - (c * d).
#
#
## Example 1
##
## Input: @ints = (5, 9, 3, 4, 6)
## Output: 42
##
## Pair 1: (9, 6)
## Pair 2: (3, 4)
## Product Diff: (9 * 6) - (3 * 4) => 54 - 12 => 42
#
#
## Example 2
##
## Input: @ints = (1, -2, 3, -4)
## Output: 10
##
## Pair 1: (1, -2)
## Pair 2: (3, -4)
#
#
## Example 3
##
## Input: @ints = (-3, -1, -2, -4)
## Output: 10
##
## Pair 1: (-1, -2)
## Pair 2: (-3, -4)
#
#
## Example 4
##
## Input: @ints = (10, 2, 0, 5, 1)
## Output: 50
##
## Pair 1: (10, 5)
## Pair 2: (0, 1)
#
#
## Example 5
##
## Input: @ints = (7, 8, 9, 10, 10)
## Output: 44
##
## Pair 1: (10, 10)
## Pair 2: (7, 8)
#
############################################################
##
## discussion
##
############################################################
#
# We pick all possible combinations of 4 numbers of the input. Then we
# create all possible diffs for those 4 numbers which due to the symmetry
# of the diff calculation and the possibility to use the absolute value of
# the diff comes down to 3 different possibilities for any set of 4 numbers.
# So we pick the max of those 3 numbers and the current max to find the
# final result in the end.

use v5.36;
use List::Util qw(max);

max_diff(5, 9, 3, 4, 6);
max_diff(1, -2, 3, -4);
max_diff(-3, -1, -2, -4);
max_diff(10, 2, 0, 5, 1);
max_diff(7, 8, 9, 10, 10);

sub max_diff(@ints) {
    say "Input: (" . join(", ", @ints) . ")";
    my $output = 0;
    foreach my $i (0..$#ints) {
        foreach my $j ($i+1..$#ints) {
            foreach my $k ($j+1..$#ints) {
                foreach my $l ($k+1..$#ints) {
                    $output = max($output,
                        abs($ints[$i]*$ints[$j] - $ints[$k]*$ints[$l]),
                        abs($ints[$i]*$ints[$k] - $ints[$j]*$ints[$l]),
                        abs($ints[$i]*$ints[$l] - $ints[$k]*$ints[$j])
                    );
                }
            }
        }
    }

    say "Output: $output";
}
