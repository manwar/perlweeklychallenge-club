#!/usr/bin/env perl

# Challenge 277
#
# Task 2: Strong Pair
# Submitted by: Mohammad Sajid Anwar
# You are given an array of integers, @ints.
#
# Write a script to return the count of all strong pairs in the given array.
#
# A pair of integers x and y is called strong pair if it satisfies: 0 < |x - y| < min(x, y).
#
# Example 1
# Input: @ints = (1, 2, 3, 4, 5)
# Ouput: 4
#
# Strong Pairs: (2, 3), (3, 4), (3, 5), (4, 5)
# Example 2
# Input: @ints = (5, 7, 1, 7)
# Ouput: 1
#
# Strong Pairs: (5, 7)

use Modern::Perl;
use List::Util 'min', 'uniq';

my @ints = uniq @ARGV;
my $count = 0;
for my $i (0..$#ints-1) {
    for my $j ($i+1..$#ints) {
        $count++ if is_strong_pair($ints[$i], $ints[$j]);
    }
}

say $count;

sub is_strong_pair {
    my($a, $b) = @_;
    return 0 < abs($a-$b) && abs($a-$b) < min($a,$b);
}
