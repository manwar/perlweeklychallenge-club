#!/usr/bin/env perl

# Challenge 160
#
# TASK #2 › Equilibrium Index
# Submitted by: Mohammad S Anwar
# You are give an array of integers, @n.
#
# Write a script to find out the Equilibrium Index of the given array, if found.
#
# For an array A consisting n elements, index i is an equilibrium index if the
# sum of elements of subarray A[0…i-1] is equal to the sum of elements of
# subarray A[i+1…n-1].
#
#
# Example 1:
# Input: @n = (1, 3, 5, 7, 9)
# Output: 3
#
# Example 2:
# Input: @n = (1, 2, 3, 4, 5)
# Output: -1 as no Equilibrium Index found.
#
# Example 3:
# Input: @n = (2, 4, 2)
# Output: 1

use Modern::Perl;
use List::Util qw( sum );

say equilibrium_index(@ARGV);

sub equilibrium_index {
    my(@n) = @_;
    for my $i (1 .. $#n-1) {
        my $left = sum(@n[0..$i-1]);
        my $right = sum(@n[$i+1..$#n]);
        return $i if $left==$right;
        return -1 if $left>$right;
    }
    return -1;
}
