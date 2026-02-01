#!/usr/bin/env perl

# Challenge 325
#
# Task 1: Consecutive One
# Submitted by: Mohammad Sajid Anwar
# You are given a binary array containing only 0 or/and 1.
#
# Write a script to find out the maximum consecutive 1 in the given array.
#
#
# Example 1
# Input: @binary = (0, 1, 1, 0, 1, 1, 1)
# Output: 3
#
# Example 2
# Input: @binary = (0, 0, 0, 0)
# Output: 0
#
# Example 3
# Input: @binary = (1, 0, 1, 0, 1, 1)
# Output: 2

use Modern::Perl;
use List::Util qw(max);

@ARGV or die "usage: $0 bin...\n";
my $bin = join '', @ARGV;
my $max = 0;
while ($bin =~ /1+/g) {
    $max = max($max, length($&));
}
say $max;
