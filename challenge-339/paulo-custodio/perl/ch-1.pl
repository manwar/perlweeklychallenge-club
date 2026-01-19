#!/usr/bin/env perl

# Challenge 339
#
# Task 1: Max Diff
# Submitted by: Mohammad Sajid Anwar
# You are given an array of integers having four or more elements.
#
# Write a script to find two pairs of numbers from this list (four numbers total) so that the difference between their products is as large as possible.
#
# In the end return the max difference.
#
# With Two pairs (a, b) and (c, d), the product difference is (a * b) - (c * d).
#
#
# Example 1
# Input: @ints = (5, 9, 3, 4, 6)
# Output: 42
#
# Pair 1: (9, 6)
# Pair 2: (3, 4)
# Product Diff: (9 * 6) - (3 * 4) => 54 - 12 => 42
#
# Example 2
# Input: @ints = (1, -2, 3, -4)
# Output: 10
#
# Pair 1: (1, -2)
# Pair 2: (3, -4)
#
# Example 3
# Input: @ints = (-3, -1, -2, -4)
# Output: 10
#
# Pair 1: (-1, -2)
# Pair 2: (-3, -4)
#
# Example 4
# Input: @ints = (10, 2, 0, 5, 1)
# Output: 50
#
# Pair 1: (10, 5)
# Pair 2: (0, 1)
#
# Example 5
# Input: @ints = (7, 8, 9, 10, 10)
# Output: 44
#
# Pair 1: (10, 10)
# Pair 2: (7, 8)

use Modern::Perl;
use List::Util qw(max);

@ARGV or die "usage: $0 nums..\n";
say max_diff(@ARGV);

sub max_diff {
    my(@nums) = @ARGV;
    return 0 if @nums < 4;

    my $max_diff = -1e10;
    my $check_pairs = sub {
        my($a, $b, $c, $d) = @_;
        my $diff1 = $a*$b-$c*$d;
        my $diff2 = $c*$d-$a*$b;
        $max_diff = max($max_diff, $diff1, $diff2);
    };

    for my $i (0 .. $#nums - 3) {
        for my $j ($i + 1 .. $#nums - 2) {
            for my $k ($j + 1 .. $#nums - 1) {
                for my $l ($k + 1 .. $#nums) {
                    # We have 4 distinct elements: $nums[$i], $nums[$j], $nums[$k], $nums[$l]
                    # There are exactly 3 ways to split these into 2 disjoint pairs:
                    $check_pairs->($nums[$i], $nums[$j], $nums[$k], $nums[$l]);
                    $check_pairs->($nums[$i], $nums[$k], $nums[$j], $nums[$l]);
                    $check_pairs->($nums[$i], $nums[$l], $nums[$j], $nums[$k]);
                }
            }
        }
    }

    return $max_diff;
}
