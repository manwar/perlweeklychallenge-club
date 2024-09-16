#!/usr/bin/env perl

# Challenge 234
#
# Task 2: Unequal Triplets
# Submitted by: Mohammad S Anwar
#
# You are given an array of positive integers.
#
# Write a script to find the number of triplets (i, j, k) that satisfies
# num[i] != num[j], num[j] != num[k] and num[k] != num[i].
# Example 1
#
# Input: @ints = (4, 4, 2, 4, 3)
# Ouput: 3
#
# (0, 2, 4) because 4 != 2 != 3
# (1, 2, 4) because 4 != 2 != 3
# (2, 3, 4) because 2 != 4 != 3
#
# Example 2
#
# Input: @ints = (1, 1, 1, 1, 1)
# Ouput: 0
#
# Example 3
#
# Input: @ints = (4, 7, 1, 10, 7, 4, 1, 1)
# Output: 28
#
# triplets of 1, 4, 7  = 3x2×2 = 12 combinations
# triplets of 1, 4, 10 = 3×2×1 = 6  combinations
# triplets of 4, 7, 10 = 2×2×1 = 4  combinations
# triplets of 1, 7, 10 = 3x2x1 = 6 combinations

use Modern::Perl;

my @nums = @ARGV;
my $count = 0;
for my $i (0 .. $#nums-2) {
    for my $j ($i+1 .. $#nums-1) {
        for my $k ($j+1 .. $#nums) {
            $count++ if $nums[$i] != $nums[$j] &&
                        $nums[$j] != $nums[$k] &&
                        $nums[$k] != $nums[$i];
        }
    }
}
say $count;
