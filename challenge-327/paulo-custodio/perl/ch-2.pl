#!/usr/bin/env perl

# Challenge 327
#
# Task 2: MAD
# Submitted by: Mohammad Sajid Anwar
# You are given an array of distinct integers.
#
# Write a script to find all pairs of elements with minimum absolute difference (MAD) of any two elements.
#
#
# Example 1
# Input: @ints = (4, 1, 2, 3)
# Output: [1,2], [2,3], [3,4]
#
# The minimum absolute difference is 1.
# Pairs with MAD: [1,2], [2,3], [3,4]
#
# Example 2
# Input: @ints = (1, 3, 7, 11, 15)
# Output: [1,3]
#
# Example 3
# Input: @ints = (1, 5, 3, 8)
# Output: [1,3], [3,5]

use Modern::Perl;
use List::Util qw(min);

@ARGV or die "usage: $0 nums...\n";

my @nums = @ARGV;
my $mad = get_mad(@nums);
my @pairs = get_pairs($mad, @nums);
say join ", ", map {"[$_]"} map {join ",", @$_} @pairs;

sub get_mad {
    my(@nums) = @_;
    @nums = sort {$a<=>$b} @nums;
    my $mad = 1e10;
    for my $i (0 .. $#nums-1) {
        $mad = min($mad, abs($nums[$i]-$nums[$i+1]));
    }
    return $mad;
}

sub get_pairs {
    my($mad, @nums) = @_;
    @nums = sort {$a<=>$b} @nums;
    my @pairs;
    for my $i (0 .. $#nums-1) {
        if ($mad == abs($nums[$i]-$nums[$i+1])) {
            push @pairs, [$nums[$i], $nums[$i+1]];
        }
    }
    return @pairs;
}
