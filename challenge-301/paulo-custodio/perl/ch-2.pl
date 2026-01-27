#!/usr/bin/env perl

# Challenge 301
#
# Task 2: Hamming Distance
# Submitted by: Mohammad Sajid Anwar
# You are given an array of integers, @ints.
#
# Write a script to return the sum of Hamming distances between all the pairs of the integers in the given array of integers.
#
#
# The Hamming distance between two integers is the number of places in which their binary representations differ.
#
# Example 1
# Input: @ints = (4, 14, 2)
# Output: 6
#
# Binary representation:
# 4  => 0100
# 14 => 1110
# 2  => 0010
#
# HammingDistance(4, 14) + HammingDistance(4, 2) + HammingDistance(14, 2) = 2 + 2 + 2 = 6.
# Example 2
# Input: @ints = (4, 14, 4)
# Output: 4

use Modern::Perl;

@ARGV or die "usage: $0 nums...\n";
say distance(@ARGV);

sub hamming_distance {
    my($a, $b) = @_;
    my $distance = 0;
    while ($a > 0 || $b > 0) {
        my $bit_a = $a & 1;
        my $bit_b = $b & 1;
        $distance++ if $bit_a != $bit_b;
        $a >>= 1;
        $b >>= 1;
    }
    return $distance;
}

sub distance {
    my(@nums) = @_;
    my $distance = 0;
    for my $i (0 .. $#nums-1) {
        for my $j ($i+1 .. $#nums) {
            $distance += hamming_distance($nums[$i], $nums[$j]);
        }
    }
    return $distance;
}
