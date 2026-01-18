#!/usr/bin/env perl

# Challenge 294
#
# Task 1: Consecutive Sequence
# Submitted by: Mohammad Sajid Anwar
# You are given an unsorted array of integers, @ints.
#
# Write a script to return the length of the longest consecutive elements sequence. Return -1 if none found. The algorithm must runs in O(n) time.
#
# Example 1
# Input: @ints = (10, 4, 20, 1, 3, 2)
# Output: 4
#
# The longest consecutive sequence (1, 2, 3, 4).
# The length of the sequence is 4.
# Example 2
# Input: @ints = (0, 6, 1, 8, 5, 2, 4, 3, 0, 7)
# Output: 9
# Example 3
# Input: @ints = (10, 30, 20)
# Output: -1

use Modern::Perl;

@ARGV or die "usage: $0 nums...\n";
say longest_sequence(@ARGV);

sub longest_sequence {
    my(@nums) = @_;
    @nums = sort {$a<=>$b} @nums;
    my $longest = -1;
    while (@nums) {
        my $i = 1;
        while ($i < @nums && $nums[$i-1]+1 == $nums[$i]) {
            $i++;
        }
        my $length = $i;
        if ($length >= 2) {
            $longest = $length if $longest < $length;
        }
        splice(@nums, 0, $i);
    }
    return $longest;
}
