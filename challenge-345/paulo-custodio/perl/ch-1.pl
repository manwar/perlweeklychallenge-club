#!/usr/bin/env perl

# Challenge 345
#
# Task 1: Peak Positions
# Submitted by: Mohammad Sajid Anwar
# You are given an array of integers, @ints.
#
# Find all the peaks in the array, a peak is an element that is strictly greater than its left and right neighbours. Return the indices of all such peak positions.
#
#
# Example 1
# Input: @ints = (1, 3, 2)
# Output: (1)
#
# Example 2
# Input: @ints = (2, 4, 6, 5, 3)
# Output: (2)
#
# Example 3
# Input: @ints = (1, 2, 3, 2, 4, 1)
# Output: (2, 4)
#
# Example 4
# Input: @ints = (5, 3, 1)
# Output: (0)
#
# Example 5
# Input: @ints = (1, 5, 1, 5, 1, 5, 1)
# Output: (1, 3, 5)

use Modern::Perl;

@ARGV or die "usage: $0 nums...\n";
my @peeks = find_peeks(@ARGV);
say join ", ", @peeks;

sub find_peeks {
    my(@n) = @_;
    return (0) if @n < 3;
    my @peeks;
    for my $i (1 .. $#n-1) {
        if ($n[$i] > $n[$i-1] && $n[$i] > $n[$i+1]) {
            push @peeks, $i;
        }
    }
    return (0) if @peeks==0;
    return @peeks;
}
