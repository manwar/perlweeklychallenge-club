#!/usr/bin/env perl

# Challenge 267
#
# Task 1: Product Sign
# Submitted by: Mohammad Sajid Anwar
#
# You are given an array of @ints.
#
# Write a script to find the sign of product of all integers in the given array.
# The sign is 1 if the product is positive, -1 if the product is negative and
# 0 if product is zero.
# Example 1
#
# Input: @ints = (-1, -2, -3, -4, 3, 2, 1)
# Output: 1
#
# The product -1 x -2 x -3 x -4 x 3 x 2 x 1 => 144 > 0
#
# Example 2
#
# Input: @ints = (1, 2, 0, -2, -1)
# Output: 0
#
# The product 1 x 2 x 0 x -2 x -1 => 0
#
# Example 3
#
# Input: @ints = (-1, -1, 1, -1, 2)
# Output: -1
#
# The product -1 x -1 x 1 x -1 x 2 => -2 < 0

use Modern::Perl;
use List::Util 'product';

my $prod = product(@ARGV);
say $prod>0 ? 1 : $prod==0 ? 0 : -1;
