#!/usr/bin/env perl

# You are given an array of positive integers.
# 
# Write a script to separate the given array into single digits.
# 
# Example 1
# Input: @ints = (1, 34, 5, 6)
# Output: (1, 3, 4, 5, 6)
# Example 2
# Input: @ints = (1, 24, 51, 60)
# Output: (1, 2, 4, 5, 1, 6, 0)

use strict;
use warnings;

use Test::More;
use feature qw(signatures say);

sub reduce($ints) {
   return map { split '' } @$ints
}

is_deeply([reduce([1, 34, 5, 6])], [1, 3, 4, 5, 6], "ok?");
is_deeply([reduce([1, 24, 51, 60])], [1, 2, 4, 5, 1, 6, 0], "ok?");

done_testing(2)
