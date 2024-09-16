#!/usr/bin/env perl

# Challenge 221
#
# Task 2: Arithmetic Subsequence
# Submitted by: Mohammad S Anwar
# You are given an array of integers, @ints.
#
# Write a script to find the length of the longest Arithmetic Subsequence in
# the given array.
#
#
# A subsequence is an array that can be derived from another array by deleting
# some or none elements without changing the order of the remaining elements.
#
# A subsquence is arithmetic if ints[i + 1] - ints[i] are all the same value
# (for 0 <= i < ints.length - 1).
#
#
# Example 1:
# Input: @ints = (9, 4, 7, 2, 10)
# Output: 3
#
# The longest Arithmetic Subsequence (4, 7, 10) can be derived by deleting
# 9 and 2.
# Example 2:
# Input: @ints = (3, 6, 9, 12)
# Output: 4
#
# No need to remove any elements, it is already an Arithmetic Subsequence.
# Example 3:
# Input: @ints = (20, 1, 15, 3, 10, 5, 8)
# Output: 4
#
# The longest Arithmetic Subsequence (20, 15, 10, 5) can be derived by deleting
# 1, 3 and 8.

use Modern::Perl;
use List::Util 'max';

my @ints = @ARGV;
my $max_sequence = 0;
for my $i (0 .. $#ints-1) {
    for my $j ($i+1 .. $#ints) {
        my $sequence = find_sequence($ints[$i], @ints[$j .. $#ints]);
        $max_sequence = max($max_sequence, $sequence);
    }
}
say $max_sequence;

sub find_sequence {
    my(@ints) = @_;
    @ints >= 2 or die;
    my $cur = shift @ints;
    my $delta = $ints[0] - $cur;
    my $sequence = 1;
    while (@ints) {
        my $next = $cur+$delta;
        while (@ints && $ints[0] != $next) {
            shift @ints;
        }
        if (@ints) {
            $cur += $delta;
            shift @ints;
            $sequence++;
        }
    }
    return $sequence;
}
