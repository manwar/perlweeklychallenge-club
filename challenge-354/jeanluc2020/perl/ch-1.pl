#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-354/#TASK1
#
# Task 1: Min Abs Diff
# ====================
#
# You are given an array of distinct integers.
#
# Write a script to find all pairs of elements with the minimum absolute difference.
#
# Rules (a,b):
# 1: a, b are from the given array.
# 2: a < b
# 3: b - a = min abs diff any two elements in the given array
#
## Example 1
##
## Input: @ints= (4, 2, 1, 3)
## Output: [1, 2], [2, 3], [3, 4]
#
#
## Example 2
##
## Input: @ints = (10, 100, 20, 30)
## Output: [10, 20], [20, 30]
#
#
## Example 3
##
## Input: @ints = (-5, -2, 0, 3)
## Output: [-2, 0]
#
#
## Example 4
##
## Input: @ints = (8, 1, 15, 3)
## Output: [1, 3]
#
#
## Example 5
##
## Input: @ints = (12, 5, 9, 1, 15)
## Output: [9, 12], [12, 15]
#
############################################################
##
## discussion
##
############################################################
#
# We keep track of the min abs diff and all ordered pairs with
# a diff that doesn't exceed the current min. That way, we can
# do a single pass over all pairs and end up with a hash that
# contains all pairs for the min abs diff. Then we can just
# output that.

use v5.36;

min_abs_diff(4, 2, 1, 3);
min_abs_diff(10, 100, 20, 30);
min_abs_diff(-5, -2, 0, 3);
min_abs_diff(8, 1, 15, 3);
min_abs_diff(12, 5, 9, 1, 15);

sub min_abs_diff(@ints) {
    say "Output: (" . join(", ", @ints) . ")";
    my $min = abs($ints[0] - $ints[1]);
    my $found = {};
    foreach my $i (0..$#ints) {
        foreach my $j ($i+1..$#ints) {
            my $current = abs($ints[$j] - $ints[$i]);
            $min = $current if $current < $min;
            push @{ $found->{$current} },
                $ints[$i] < $ints[$j] ? "[$ints[$i], $ints[$j]]" : "[$ints[$j], $ints[$i]]"
                if $current <= $min;
        }
    }
    say "Output: " . join(", ", @{$found->{$min}});
}
