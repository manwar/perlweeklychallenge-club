#!/usr/bin/env perl

# Challenge 244
#
# Task 1: Count Smaller
# Submitted by: Mohammad S Anwar
#
# You are given an array of integers.
#
# Write a script to calculate the number of integers smaller than the integer
# at each index.
# Example 1
#
# Input: @int = (8, 1, 2, 2, 3)
# Output: (4, 0, 1, 1, 3)
#
# For index = 0, count of elements less 8 is 4.
# For index = 1, count of elements less 1 is 0.
# For index = 2, count of elements less 2 is 1.
# For index = 3, count of elements less 2 is 1.
# For index = 4, count of elements less 3 is 3.
#
# Example 2
#
# Input: @int = (6, 5, 4, 8)
# Output: (2, 1, 0, 3)
#
# Example 3
#
# Input: @int = (2, 2, 2)
# Output: (0, 0, 0)

use Modern::Perl;

@ARGV or die "Usage: $0 n n n...\n";

my @nums = @ARGV;
my @smaller;

for my $i (0..$#nums) {
    $smaller[$i] = 0;
    for my $j (0..$#nums) {
        $smaller[$i]++ if $nums[$j] < $nums[$i];
    }
}

say "@smaller";
