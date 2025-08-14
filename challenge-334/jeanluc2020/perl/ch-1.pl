#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-334/#TASK1
#
# Task 1: Range Sum
# =================
#
# You are given a list integers and pair of indices..
#
# Write a script to return the sum of integers between the given indices (inclusive).
#
## Example 1
##
## Input: @ints = (-2, 0, 3, -5, 2, -1), $x = 0, $y = 2
## Output: 1
##
## Elements between indices (0, 2) => (-2, 0, 3)
## Range Sum: (-2) + 0 + 3 => 1
#
#
## Example 2
##
## Input: @ints = (1, -2, 3, -4, 5), $x = 1, $y = 3
## Output: -3
##
## Elements between indices (1, 3) => (-2, 3, -4)
## Range Sum: (-2) + 3 + (-4) => -3
#
#
## Example 3
##
## Input: @ints = (1, 0, 2, -1, 3), $x = 3, $y = 4
## Output: 2
##
## Elements between indices (3, 4) => (-1, 3)
## Range Sum: (-1) + 3 => 2
#
#
## Example 4
##
## Input: @ints = (-5, 4, -3, 2, -1, 0), $x = 0, $y = 3
## Output: -2
##
## Elements between indices (0, 3) => (-5, 4, -3, 2)
## Range Sum: (-5) + 4 + (-3) + 2 => -2
#
#
## Example 5
##
## Input: @ints = (-1, 0, 2, -3, -2, 1), $x = 0, $y = 2
## Output: 1
##
## Elements between indices (0, 2) => (-1, 0, 2)
## Range Sum: (-1) + 0 + 2 => 1
#
############################################################
##
## discussion
##
############################################################
#
# We just need to calculate the sum of a slice of the input array.
# We use sum() from List::Util which makes the whole operation really
# easy and quick.

use v5.36;

use List::Util qw( sum );

range_sum( [-2, 0, 3, -5, 2, -1], 0, 2);
range_sum( [1, -2, 3, -4, 5], 1, 3);
range_sum( [1, 0, 2, -1, 3], 3, 4);
range_sum( [-5, 4, -3, 2, -1, 0], 0, 3);
range_sum( [-1, 0, 2, -3, -2, 1], 0, 2);

sub range_sum($ints, $x, $y) {
    say "Input: (" . join(", ", @$ints) . "), $x, $y";
    say "Output: " . sum( @$ints[$x..$y] );
}
