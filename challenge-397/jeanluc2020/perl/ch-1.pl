#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-397/#TASK1
#
# Task 1: Absent Smallest Positive
# ================================
#
# You are given an array of integers.
#
# Write a script to return the smallest absent positive integer such that it is
# strictly greater than the average of all elements in the given array.
#
## Example 1
##
## Input: @arr = (1, 2, 4, 5, 6)
## Output: 7
##
## Average: (1 + 2 + 4 + 5 + 6) / 5 = 3.6
## We need the smallest positive integer absent from nums that is strictly greater than 3.6.
## The positive integers greater than 3.6 are 4, 5, 6, 7, ....
##
## 4 is in the given array.
## 5 is in the given array.
## 6 is in the given array.
## 7 is not in.
#
## Example 2
##
## Input: @arr = (-5, -2, -1, 3)
## Output: 1
##
## Average: (-5 -2 -1 + 3) / 4 = -1.25
## We need the smallest absent positive integer strictly greater than -1.25.
## Positive integers are 1, 2, 3, 4, ... (all are strictly greater than -1.25).
##
## 1 is positive and absent from the given array.
#
## Example 3
##
## Input: @arr = (1, 2, 3)
## Output: 4
##
## Average: (1 + 2 + 3) / 3 = 2.0
## We need an integer strictly greater than 2.0.
##
## 3 is in the given array.
## 4 is not in.
#
## Example 4
##
## Input: @arr = (2, 3, 7, 8)
## Output: 6
##
## Average: (2 + 3 + 7 + 8) / 4 = 5.0
## We need an integer strictly greater than 5.0.
##
## 6 is not in the given array.
#
## Example 5
##
## Input: @arr = (1, 1, 1, 10)
## Output: 4
##
## Average: (1 + 1 + 1 + 10) / 4 = 3.25
## Positive integers strictly greater than 3.25: 4, 5, 6, ...
##
## 4 is not in the given array.
#
############################################################
##
## discussion
##
############################################################
#
# We calculate the average, set our start at the next integer from that
# (and to 1 if that is still <1), then we simply keep adding 1 as long as
# the found integer is still in the array.

use v5.36;
use List::Util qw(sum max);
use Data::Dumper;

sub absent_smallest_integer(@arr) {
    say "Input: (" . join(", ", @arr) . ")";
    my $count = scalar(@arr);
    return say "Empty array, not output" unless $count > 0;
    my $max = max(@arr);
    return say "Output: 1" if $max < 1;
    my $sum = sum(@arr);
    my $avg = $sum / $count;
    my %found = map { $_ => 1, } @arr;
    my $start = $avg;
    $start = int($start) + 1;
    $start = 1 if $start < 1;
    while($found{$start}) {
        $start++;
    }
    say "Output: $start";
}


absent_smallest_integer(1, 2, 4, 5, 6);
absent_smallest_integer(-5, -2, -1, 3);
absent_smallest_integer(1, 2, 3);
absent_smallest_integer(2, 3, 7, 8);
absent_smallest_integer(1, 1, 1, 10);
