#!/usr/bin/env perl

# Challenge 283
#
# Task 1: Unique Number
# Submitted by: Mohammad Sajid Anwar
#
# You are given an array of integers, @ints, where every elements appears more than once except one element.
#
# Write a script to find the one element that appears exactly one time.
# Example 1
#
# Input: @ints = (3, 3, 1)
# Output: 1
#
# Example 2
#
# Input: @ints = (3, 2, 4, 2, 4)
# Output: 3
#
# Example 3
#
# Input: @ints = (1)
# Output: 1
#
# Example 4
#
# Input: @ints = (4, 3, 1, 1, 1, 4)
# Output: 3

use Modern::Perl;

my @ints = @ARGV;
my %count;
for (@ints) {
    $count{$_}++;
}
my($unique) = map {$_->[0]} grep {$count{$_->[0]}==1} map {[$_, $count{$_}]} @ints;
say $unique;
