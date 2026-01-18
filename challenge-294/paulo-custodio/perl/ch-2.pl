#!/usr/bin/env perl

# Challenge 294
#
# Task 2: Next Permutation
# Submitted by: Mohammad Sajid Anwar
# You are given an array of integers, @ints.
#
# Write a script to find out the next permutation of the given array.
#
# The next permutation of an array of integers is the next lexicographically greater permutation of its integer.
#
# Example 1
# Input: @ints = (1, 2, 3)
# Output: (1, 3, 2)
#
# Permutations of (1, 2, 3) arranged lexicographically:
# (1, 2, 3)
# (1, 3, 2)
# (2, 1, 3)
# (2, 3, 1)
# (3, 1, 2)
# (3, 2, 1)
# Example 2
# Input: @ints = (2, 1, 3)
# Output: (2, 3, 1)
# Example 3
# Input: @ints = (3, 1, 2)
# Output: (3, 2, 1)

use Modern::Perl;

@ARGV or die "usage: $0 nums...\n";

say join ", ", next_permutation(@ARGV);

sub next_permutation {
    my(@nums) = @_;

    # Find the longest not increasing suffix
    my $pivot;
    for my $i (reverse 0 .. $#nums-1) {
        if ($nums[$i] < $nums[$i+1]) {
            $pivot = $i;
            last;
        }
    }
    return () unless defined $pivot;    # not found, sequence was lasy one

    # find the rightmost successor to the pivot
    my $successor;
    for my $i (reverse 0 .. $#nums) {
        if ($nums[$i] > $nums[$pivot]) {
            $successor = $i;
            last;
        }
    }

    # swap the pivot with the successor
    ($nums[$pivot], $nums[$successor]) = ($nums[$successor], $nums[$pivot]);

    # reverse suffix
    @nums[$pivot+1..$#nums] = reverse @nums[$pivot+1..$#nums];

    return @nums;
}
