#!/usr/bin/env perl

# Challenge 225
#
# Task 2: Left Right Sum Diff
# Submitted by: Mohammad S Anwar
# You are given an array of integers, @ints.
#
# Write a script to return left right sum diff array as shown below:
#
#
# @ints = (a, b, c, d, e)
#
# @left  = (0, a, (a+b), (a+b+c))
# @right = ((c+d+e), (d+e), e, 0)
# @left_right_sum_diff = ( | 0 - (c+d+e) |,
#                          | a - (d+e)   |,
#                          | (a+b) - e   |,
#                          | (a+b+c) - 0 | )
#
# Example 1:
# Input: @ints = (10, 4, 8, 3)
# Output: (15, 1, 11, 22)
#
# @left  = (0, 10, 14, 22)
# @right = (15, 11, 3, 0)
#
# @left_right_sum_diff = ( |0-15|, |10-11|, |14-3|, |22-0|)
#                      = (15, 1, 11, 22)
# Example 2:
# Input: @ints = (1)
# Output: (0)
#
# @left  = (0)
# @right = (0)
#
# @left_right_sum_diff = ( |0-0| ) = (0)
# Example 3:
# Input: @ints = (1, 2, 3, 4, 5)
# Output: (14, 11, 6, 1, 10)
#
# @left  = (0, 1, 3, 6, 10)
# @right = (14, 12, 9, 5, 0)
#
# @left_right_sum_diff = ( |0-14|, |1-12|, |3-9|, |6-5|, |10-0|)
#                      = (14, 11, 6, 1, 10)

use Modern::Perl;

my @ints = @ARGV;
my @sum = right_sum_diff(@ints);
say "@sum";

sub right_sum_diff {
    my(@ints) = @_;

    my $sum = 0;
    my @left = ($sum);
    for (@ints[0..$#ints-1]) {
        $sum += $_;
        push @left, $sum;
    }

    $sum = 0;
    my @right = ($sum);
    for (reverse @ints[1..$#ints]) {
        $sum += $_;
        unshift @right, $sum;
    }

    my @sum;
    for (0..$#ints) {
        push @sum, abs($left[$_]-$right[$_]);
    }
    return @sum;
}
