#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-338/#TASK1
#
# Task 1: Highest Row
# ===================
#
# You are given a m x n matrix.
#
# Write a script to find the highest row sum in the given matrix.
#
## Example 1
##
## Input: @matrix = ([4,  4, 4, 4],
##                   [10, 0, 0, 0],
##                   [2,  2, 2, 9])
## Output: 16
##
## Row 1: 4  + 4 + 4 + 4 => 16
## Row 2: 10 + 0 + 0 + 0 => 10
## Row 3: 2  + 2 + 2 + 9 => 15
#
#
## Example 2
##
## Input: @matrix = ([1, 5],
##                   [7, 3],
##                   [3, 5])
## Output: 10
#
#
## Example 3
##
## Input: @matrix = ([1, 2, 3],
##                   [3, 2, 1])
## Output: 6
#
#
## Example 4
##
## Input: @matrix = ([2, 8, 7],
##                   [7, 1, 3],
##                   [1, 9, 5])
## Output: 17
#
#
## Example 5
##
## Input: @matrix = ([10, 20,  30],
##                   [5,  5,   5],
##                   [0,  100, 0],
##                   [25, 25,  25])
## Output: 100
#
############################################################
##
## discussion
##
############################################################
#
# This one is very simple with a little help of List::Util:
# We just create all the sums using sum() and calculate the
# maximum of those using max(). map() helps to put everything
# into a single line.

use v5.36;
use List::Util qw(max sum);

highest_row([4,  4, 4, 4], [10, 0, 0, 0], [2,  2, 2, 9]);
highest_row([1, 5], [7, 3], [3, 5]);
highest_row([1, 2, 3], [3, 2, 1]);
highest_row([2, 8, 7], [7, 1, 3], [1, 9, 5]);
highest_row([10, 20,  30], [5,  5,   5], [0,  100, 0], [25, 25,  25]);

sub highest_row( @matrix ) {
    say "Input: \@matrix = (";
    foreach my $line (@matrix) {
        say "    [" . join(", ", @$line) . "],";
    }
    say " )";
    say "Output: " . max( map { sum(@{$_}) } @matrix);
}
