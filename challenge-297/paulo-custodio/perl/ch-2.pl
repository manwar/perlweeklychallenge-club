#!/usr/bin/env perl

# Challenge 297
#
# Task 2: Semi-Ordered Permutation
# Submitted by: Mohammad Sajid Anwar
# You are given permutation of $n integers, @ints.
#
# Write a script to find the minimum number of swaps needed to make the @ints a semi-ordered permutation.
#
# A permutation is a sequence of integers from 1 to n of length n containing  each number exactly once.
# A permutation is called semi-ordered if the first number is 1 and the last number equals n.
# You are ONLY allowed to pick adjacent elements and swap them.
#
# Example 1
# Input: @ints = (2, 1, 4, 3)
# Output: 2
#
# Swap 2 <=> 1 => (1, 2, 4, 3)
# Swap 4 <=> 3 => (1, 2, 3, 4)
# Example 2
# Input: @ints = (2, 4, 1, 3)
# Output: 3
#
# Swap 4 <=> 1 => (2, 1, 4, 3)
# Swap 2 <=> 1 => (1, 2, 4, 3)
# Swap 4 <=> 3 => (1, 2, 3, 4)
# Example 3
# Input: @ints = (1, 3, 2, 4, 5)
# Output: 0
#
# Already a semi-ordered permutation.

use Modern::Perl;
use List::Util qw(min max);

@ARGV or die "usage: $0 nums...\n";
say num_swaps(@ARGV);

sub num_swaps {
    my(@nums) = @_;
    my $min = min(@nums);
    my $min_idx = (map {$_->[0]} grep {$_->[1]==$min} map {[$_, $nums[$_]]} 0..$#nums)[0];

    # must move the minimum to the front, because it may impact the maximum position
    for my $i (reverse 0 .. $min_idx-1) {
        ($nums[$i+1], $nums[$i]) = ($nums[$i], $nums[$i+1]);
    }

    # no need to reorder the array
    my $max = max(@nums);
    my $max_idx = (map {$_->[0]} grep {$_->[1]==$max} map {[$_, $nums[$_]]} reverse 0..$#nums)[0];
    return $min_idx + ($#nums-$max_idx);
}
